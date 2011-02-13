class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.timestamps

      t.date :start_date, :null => false
      t.date :end_date, :null => false

      t.time :start_time, :null => false
      t.time :end_time, :null => false

      t.boolean :monday, :default => false
      t.boolean :tuesday, :default => false
      t.boolean :wednesday, :default => false
      t.boolean :thursday, :default => false
      t.boolean :friday, :default => false
      t.boolean :saturday, :default => false
      t.boolean :sunday, :default => false
      t.boolean :monday, :default => false

      t.references :course

      t.string :period, :null => false
    end
  end

  def self.down
    drop_table :schedules
  end
end
