class HomeController < ApplicationController

	def index
		@artists = Artist.first(50)
	end
	
end
