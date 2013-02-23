class SessionsController < ApplicationController
  def new
  end
  
  def create
    #binding.pry
  	@users = User.authenticate(params[:session][:username], params[:session][:password])
    
  	if @users
  		session[:user_id] = @users.id
  		redirect_to :controller => "photos", :action => "new", :notice => "You have successfully logged in"
  	else
  		flash.now.alert = "Invalid email or password"
      render "new"
  	end
    
    
  end
  
  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "You have sucessfully logged out"
  end
  
end