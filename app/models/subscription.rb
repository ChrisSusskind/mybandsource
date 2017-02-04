class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  validates :user_id, :artist_id, presence: true
end
