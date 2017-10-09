# This class encompasses all users of the site. It includes both artists and fans.
class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook]


  # Artist users scope
  scope :artists, -> { where(is_artist: true)}

  # For user to review associations
  has_many :received_reviews, class_name: 'Review', foreign_key: 'receiving_user_id', dependent: :destroy
  has_many :left_reviews, class_name: 'Review', foreign_key: 'leaving_user_id', dependent: :destroy

  # For user to response associations
  has_many :responses, dependent: :destroy

  # For user to genre associations
  belongs_to :genre, optional: true

  # For user to user relationships
  has_many :active_relationships, class_name: 'UserRelationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'UserRelationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # For user to notification relationships
  has_many :notifications, foreign_key: 'receiving_user_id', dependent: :destroy

  validates :name, :email, presence: true

  mount_uploader :picture, AvatarUploader
  mount_uploader :banner_picture, AvatarUploader

  def increment_response_count
    if self.response_count != nil
      self.response_count += 1
    else
      self.response_count = 1
    end
    self.save
  end

  def decrement_response_count
    self.response_count -= 1
    self.save
  end

  def new_avg_rating_review_count(rating)
    avg_rating = self.average_rating.nil? ? 0 : self.average_rating
    rc = self.review_count.nil? ? 0 : self.review_count

    self.average_rating = (avg_rating * rc + rating) / (rc + 1)
    self.review_count = rc + 1
    self.save
  end

  def change_rating(old_rating, new_rating)
    self.average_rating = (self.average_rating * self.review_count - old_rating + new_rating) / self.review_count
    self.save
  end

  def delete_avg_rating_review_count(rating)
    if self.review_count == 1
      self.average_rating = 0.0
    else
      self.average_rating = (self.average_rating * self.review_count - rating) / self.review_count - 1
    end
    self.review_count -= 1
    self.save
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.from_omniauth(auth)
    if User.where("email = ? OR uid = ?", auth.info.email, auth.uid).count < 1
      User.create(name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0, 20], provider: auth.provider, uid: auth.uid, picture: auth.info.image)
    else
      user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
      return user

    end
  end

  def rating
    sum = 0.0
    count = 0.0
    received_reviews.each do |review|
      count += 1
      sum += review.rating
    end
    return count.zero? ? 0 : (sum / count).round(2)
  end

  protected

  def confirmation_required?
    false
  end

end
