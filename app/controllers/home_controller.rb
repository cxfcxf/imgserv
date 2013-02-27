class HomeController < ApplicationController
	def index
		if user_signed_in?
			redirect_to :controller => "photos", :action => "new"
		end
	end
	
	
end
