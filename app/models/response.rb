class Response < ApplicationRecord
  belongs_to :user
  belongs_to :review

  has_many :notifications, dependent: :destroy

  validates :user_id, :review_id, :comment, presence: true
end
