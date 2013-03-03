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
   # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   "uploads/#{Time.now.year.to_s}/#{Time.now.month.to_s}/#{Time.now.day.to_s}"
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
      process :resize_to_limit => [200, 200]
   end
   
  def require_embed_text?(file)
    return model.require_embed_text?
  end

  version :embed, :if => :require_embed_text? do
    process :text_embed
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


def text_embed
  cache_stored_file! if !cached?
  
  manipulate! do |source|
    text = model.embed_text

    txt = Draw.new
    txt.gravity = Magick::SouthGravity
    txt.pointsize = 32
    txt.stroke = 'transparent'
    txt.font_weight = Magick::BoldWeight
    txt.font = Rails.root.join('fonts', 'YaHei.ttf').to_s
    txt.font_family = 'Helvetica'
    txt.fill = 'white'
    source = source.resize_to_fill(300, 300).border(10, 10, "black")
    source.annotate(txt, 0, 0, 0, 40, text)
  end
end

end
