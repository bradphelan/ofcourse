class ChangeSchedules < ActiveRecord::Migration
  def self.up
    remove_column :schedules, :start_date
    add_column :schedules, :start_date, :datetime, :null => false
    remove_column :schedules, :start_time
    remove_column :schedules, :end_time
  end

  def self.down
  end
end
