class AddUserStatus < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :boolean, :default => true, :null => false
    add_column :users, :preferences, :text
  end

  def self.down
    remove_column :users, :status
    remove_column :users, :preferences
  end
end
