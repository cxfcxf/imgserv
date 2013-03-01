class PhotosController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		
		uid = current_user.id
		
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
		uid = current_user.id
		
		@p = Photo.new(:user_id => uid)
		@p.imgdir = params[:photo][:file]
		
		if @p.save!
			redirect_to :action => 'new'
		else
			redirect_to :action => 'new'
		end
	end
	
	def destroy
		@img = Photo.find(params[:id])
		@img.destroy
		
		if @img.save!
			redirect_to :action => "new"
		end
	end
	
	def edit
		@photo = Photo.find(params[:id])
	end
	
	def update
		@photo = Photo.find(params[:id])
		if @photo.update_attributes(params[:photo])
			redirect_to :action => "new"
		else
			render :edit
		end
	end

end