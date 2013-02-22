class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :imgdir
      t.date :uploadtime

      t.timestamps
    end
  end
end
