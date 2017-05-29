class Notification < ApplicationRecord
  belongs_to :receiving_user, class_name: 'User'
  belongs_to :review
  belongs_to :response

  validates :generating_user_id, :receiving_user_id, :generating_user_name, presence: true
end
