class ScheduleDurationToSeconds < ActiveRecord::Migration
  def self.up
    remove_column :schedules, :duration
    add_column :schedules, :duration, :integer, :null => false
  end

  def self.down
  end
end
