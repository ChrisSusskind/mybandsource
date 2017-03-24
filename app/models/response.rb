class Response < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, :review_id, presence: true
end
