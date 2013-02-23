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
		uid = session[:user_id]
		Photo.create(:user_id => uid, :imgdir => filesavepath.to_s)
		
		FileUtils.mv tmp_file.path, filesavepath
		
		if $? == 0
			redirect_to :action => 'new'
		else
			redirect_to :action => 'new'
		end
	end
	
	def upload_successed!
	end
	
	def upload_failed!
	end
	
end