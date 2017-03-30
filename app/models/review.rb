class Review < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  has_many :responses, dependent: :destroy

  validates :user_id, :artist_id, presence: true
end
