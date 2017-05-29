class Review < ApplicationRecord
  belongs_to :receiving_user, class_name: 'User'
  belongs_to :leaving_user, class_name: 'User'

  has_many :responses, dependent: :destroy

  has_many :notifications, dependent: :destroy

  validates :receiving_user_id, :leaving_user_id, presence: true
end
