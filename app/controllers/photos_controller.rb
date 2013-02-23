class PhotosController < ApplicationController
	def new
		uid = session[:user_id]
		
		@photos = Photo.new
		
		#binding.pry
		@images = Photo.find(:all, :conditions => {:user_id => uid})
		
	end
	
#	def create
#		binding.pry
#		tmp_file = params[:photo][:file]
#		t = Time.now.to_i
#		suffix = tmp_file.original_filename.split('.').last
#		filesavepath = Rails.root.join("imgfile", t.to_s + '.' + suffix)
#		uid = session[:user_id]
#		Photo.create(:user_id => uid, :imgdir => filesavepath.to_s)
#		
#		FileUtils.mv tmp_file.path, filesavepath
#		
#		if $? == 0
#			redirect_to :action => 'new'
#		else
#			redirect_to :action => 'new'
#		end
#	end

	def create
		uid = session[:user_id]
		
		p = Photo.new(:user_id => uid)
		p.imgdir = params[:photo][:file]
		
		if p.save!
			redirect_to :action => 'new'
		else
			redirect_to :action => 'new'
		end
	end

end