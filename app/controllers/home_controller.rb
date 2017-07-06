class HomeController < ApplicationController

	def index
		@artists = User.where(is_artist: true).first(24)
		@genres = Genre.first(10)
	end
	
end
