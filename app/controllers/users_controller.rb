class UsersController < ApplicationController
	def index
	end
	
	def new
		@users = User.new
	end
	
	def create
		@users = User.new(params[:user])
		@users.save
		redirect_to :controller => 'photos', :action => 'new'
		
	end
	
	
	
end
