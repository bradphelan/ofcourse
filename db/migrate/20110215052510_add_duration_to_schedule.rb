class AddDurationToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :duration, :time, :null => false
  end

  def self.down
    remove_column :schedules, :duration
  end
end
