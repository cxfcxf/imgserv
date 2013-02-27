class AddfilenameToPhotos < ActiveRecord::Migration
  def up
  	add_column :photos, :filename, :string
  end

  def down
  end
end
