class PhotosController < ApplicationController
	def index
		@photos = Photo.new
	end
	
	def create
		tmp_file = params[:photos][:imgdir]
		t = Time.now.to_i
		FileUtils.mv tmp_file, Rails.root.join("imgfile", t.to_s)
	end
end
