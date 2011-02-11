class Role < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.timestamps
      t.string 'name', :limit => 25, :null => false
      t.string 'description', :limit =>140
    end
  end

  def self.down
  end
end
