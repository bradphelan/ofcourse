class RoleUser < ActiveRecord::Migration
  def self.up
    create_table :roles_users do |t|
      t.timestamps
      t.references :roles
      t.references :users
    end
  end

  def self.down
    drop_table :roles_users
  end
end
