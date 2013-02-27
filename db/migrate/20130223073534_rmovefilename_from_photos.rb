class RmovefilenameFromPhotos < ActiveRecord::Migration
  def up
  	remove_column :photos, :filename, :string
  end

  def down
  end
end
