class CreateCourseRegistrations < ActiveRecord::Migration
  def self.up
    create_table :course_registrations do |t|
      t.timestamps
      t.references :user
      t.references :course
    end
    drop_table :courses_users
  end

  def self.down
  end
end
