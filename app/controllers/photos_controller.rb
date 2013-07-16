class PhotosController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		
		uid = current_user.id
		
		@photos = Photo.new
		
		#binding.pry
		@images = Photo.find(:all, :conditions => {:user_id => uid})
	end

	def create
		uid = current_user.id
		
		if current_user.photos.size >= 6
			redirect_to :action => 'new'
		else
			@p = Photo.new(:user_id => uid)
			@p.imgdir = params[:photo][:file]
		
			if @p.save!
			   redirect_to :action => 'new'
		  else
			   redirect_to :action => 'new'
		  end
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
		#binding.pry
		if @photo.update_attributes(params[:photo])
			@photo.save!
			redirect_to :action => 'new'
		else
			render :edit
		end
	end

end