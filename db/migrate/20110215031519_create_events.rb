class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamps
      t.datetime :event, :null => false
      t.references :schedule
    end
  end

  def self.down
    drop_table :events
  end
end
