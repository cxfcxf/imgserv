class PhotosController < ApplicationController
	def new
		@photos = Photo.new
	end
	
	def create
#		binding.pry
		tmp_file = params[:photo][:file]
		t = Time.now.to_i
		suffix = tmp_file.original_filename.split('.').last
		filesavepath = Rails.root.join("imgfile", t.to_s + '.' + suffix)
		Photo.create(:user_id => '1', :imgdir => filesavepath.to_s)
		
		FileUtils.mv tmp_file.path, filesavepath
		
		if $? == 0
			redirect_to :action => 'index'
		else
			redirect_to :action => 'index'
		end
	end
	
	def upload_successed!
	end
	
	def upload_failed!
	end
	
end