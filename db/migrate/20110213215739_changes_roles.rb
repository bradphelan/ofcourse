class ChangesRoles < ActiveRecord::Migration
  def self.up
    drop_table :roles_users
    add_column :users, :role_id, :integer, :null => false
  end

  def self.down
    remove_column :user, :role_id
  end
end
