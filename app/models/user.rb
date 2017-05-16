class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
		 :omniauthable, :omniauth_providers => [:facebook]

	#For user to artist associations
	has_many :subscriptions
	has_many :artists, through: :subscriptions

	#For user to review associations
	has_many :reviews, dependent: :destroy

	#For user to response associations
	has_many :responses, dependent: :destroy

	#For user to user relationships
	has_many :active_relationships, class_name: "UserRelationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "UserRelationship", foreign_key: "followed_id", dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

	validates :name, presence: true

	mount_uploader :picture, AvatarUploader

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
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0, 20]
			user.name = auth.info.name  	# Assuming the user model has a name
			user.image = auth.info.image 	# Assuming the user model has an image
			# If you are using confirmable and the providers you use validate emails,
			# Uncomment the line below to skip the confirmation emails
			user.skip_confirmation!
		end
	end

end
