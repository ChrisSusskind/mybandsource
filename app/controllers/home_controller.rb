class HomeController < ApplicationController

	def index
		@artists = User.where(is_artist: true).first(25)
		@genres = Genre.first(10)
	end
	
end
