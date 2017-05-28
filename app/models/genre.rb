class Genre < ApplicationRecord
	#For genre to user/artist associations
	has_many :users, dependent: :destroy

	validates :name, presence: true
end
