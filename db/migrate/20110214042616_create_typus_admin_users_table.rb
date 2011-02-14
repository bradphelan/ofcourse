class CreateTypusAdminUsersTable < ActiveRecord::Migration
  def self.up
    create_table :admin_users
  end

  def self.down
    drop_table :admin_users
  end
end
