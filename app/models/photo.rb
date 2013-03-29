class Photo < ActiveRecord::Base
  attr_accessible :imgdir, :uploadtime, :user_id
  belongs_to :users
  mount_uploader :imgdir, ImageUploader
  attr_accessor :embed_text, :embed_color, :embed_pos, :embed_size
  attr_accessible :embed_text, :embed_color, :embed_pos, :embed_size
  before_save :reset_embed_text, :if => :require_embed_text?
  
  def reset_embed_text
  	self.imgdir.recreate_versions!
  end
  
  def require_embed_text?
  	!embed_text.blank?
  end
  
end
