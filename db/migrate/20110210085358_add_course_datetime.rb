class AddCourseDatetime < ActiveRecord::Migration
  def self.up
    add_column :courses, :date_of, :datetime, :default => Time.now
  end

  def self.down
    remove_column :courses, :date_of
  end
end
