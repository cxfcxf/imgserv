class RemoveuploadtimeFromphotos < ActiveRecord::Migration
  def up
  	remove_column :photos, :uploadtime
  end

  def down
  end
end
