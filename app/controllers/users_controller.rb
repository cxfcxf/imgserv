class UsersController < ApplicationController
	def new
		@users = User.new
	end
	
	def create
		@users = User.new(params[:user])
		if @users.save
			redirect_to :controller => 'photos', :action => 'new'
		else
			render "new"
		end
	end
end
