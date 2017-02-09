class HomeController < ApplicationController

	def index
		@artists = Artist.first(3)
		@genres = Genre.first(10)
	end
	
end
