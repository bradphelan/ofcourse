class AddNameToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :name, :string
    add_column :courses, :user_id, :integer
    add_index :courses, :user_id
  end

  def self.down
    remove_column :courses, :name
    remove_column :courses, :user_id
    remove_index :courses, :user_id
  end
end
