class RemoveConfirmableFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
  end

  def down
  end
end
