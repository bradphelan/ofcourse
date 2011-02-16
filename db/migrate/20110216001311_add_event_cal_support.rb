class AddEventCalSupport < ActiveRecord::Migration
  def self.up
    rename_column :events, :event, :start_at
    add_column :events, :end_at, :datetime, :null => false
    add_column :events, :name, :string
  end

  def self.down
  end
end
