class Genre < ApplicationRecord
	#For genre to user/artist associations
	has_many :users

	validates :name, presence: true
end
