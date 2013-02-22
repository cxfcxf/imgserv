class UploadController < ApplicationController
  def index
  	@users = User.find(:all)
  	@photos = Photo.new
  end
end
