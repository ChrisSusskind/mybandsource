class Genre < ApplicationRecord
	#For genre to user/artist associations
	has_many :users
	before_destroy :remove_users_genre, prepend: true

	validates :name, presence: true

	def remove_users_genre
		users.each do |user|
			user.genre_id = nil;
		end
	end
end
