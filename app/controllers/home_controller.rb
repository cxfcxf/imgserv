class HomeController < ApplicationController
	def index
		@images = Photo.find(:all)
		if user_signed_in?
			redirect_to :controller => "photos", :action => "new"
		end
	end
	
end
