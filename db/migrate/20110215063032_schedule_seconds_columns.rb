class ScheduleSecondsColumns < ActiveRecord::Migration
  def self.up
    add_column :schedules, :start_seconds_since_midnight, :integer, :null => false
    add_column :schedules, :end_seconds_since_midnight, :integer, :null => false
  end

  def self.down
    remove_column :schedules, :start_seconds_since_midnight
    remove_column :schedules, :end_seconds_since_midnight
  end
end
