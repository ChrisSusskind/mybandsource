class Notification < ApplicationRecord
  belongs_to :receiving_user, class_name: 'User'
  belongs_to :receiving_artist, class_name: 'Artist'
  belongs_to :review
  belongs_to :response

  validates :generating_user_id, presence: true

end