class Genre < ApplicationRecord
	#For genre to artist associations
	has_many :artists

	validates :name, presence: true
end
