class PhotosController < ApplicationController
	def index
		@photos = Photo.new
	end
	
	def create
	tmp_file = params[:photos][:imgdir]
	FileUtils.mv tmp_file, Rails.root.join("imgfile","Time.now.to_f")
	end
end
