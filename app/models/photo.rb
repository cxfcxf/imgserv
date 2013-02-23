class Photo < ActiveRecord::Base
  attr_accessible :imgdir, :uploadtime, :user_id
  belongs_to :users
  mount_uploader :imgdir, ImageUploader
end
