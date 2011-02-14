class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.timestamps
      t.string :name, :null => false, :unique => true
    end

    add_column :schedules, :room_id, :integer,  :null => false
  end

  def self.down
    drop_table :rooms
  end
end
