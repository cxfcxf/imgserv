# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include Magick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   # "uploads/#{Time.now.year.to_s}/#{Time.now.month.to_s}/#{Time.now.day.to_s}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  
   #process :resize_to_fit => [800, 800]
   version :thumb do
   #  process :scale => [50, 50]
      process :resize_to_fill => [400, 400]
   end
   
  def require_embed_text?(file)
    return model.require_embed_text?
  end

  version :embed, :if => :require_embed_text? do
    process :textEmbed
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


def textEmbed
  cache_stored_file! if !cached?
  embed_color = '#' + model.embed_color
  coords = model.embed_coords.split(",")
  coords.map! {|s| s.to_i}

#old model 
#  manipulate! do |source|
#    text = model.embed_text_south#

#    txt = Draw.new
#    txt.gravity = SouthGravity
#    txt.pointsize = model.embed_size.to_i
#    txt.stroke = embed_color
#    txt.font_weight = BoldWeight
#    txt.font = Rails.root.join('fonts', 'YaHei.ttf').to_s
#    txt.font_family = 'Helvetica'
#    txt.fill = embed_color
#    source = source.resize_to_fill(400, 400)
#    source.annotate(txt, 0, 0, 0, 5, text)
#  end
#  
#  
#  manipulate! do |source|
#    text = model.embed_text_north#

#    txt = Draw.new
#    txt.gravity = NorthGravity
#    txt.pointsize = model.embed_size.to_i
#    txt.stroke = embed_color
#    txt.font_weight = BoldWeight
#    txt.font = Rails.root.join('fonts', 'YaHei.ttf').to_s
#    txt.font_family = 'Helvetica'
#    txt.fill = embed_color
#    source = source.resize_to_fill(400, 400)
#    source.annotate(txt, 0, 0, 0, 5, text)
#  end

#new model
  manipulate! do |source|
    text = model.embed_text
    
    txt = Draw.new
#    txt.gravity = Default
    txt.pointsize = model.embed_size.to_i
    txt.stroke = embed_color
    txt.font_weight = BoldWeight
    txt.font = Rails.root.join('fonts', 'YaHei.ttf').to_s
    txt.font_family = 'Helvetica'
    txt.fill = embed_color
    source = source.resize_to_fill(400, 400)
    source.annotate(txt, coords[0], coords[1], coords[2], coords[3]+15, text)
  end


end

end