class CreateCourseUsers < ActiveRecord::Migration
  def self.up
    create_table :course_users do |t|
      t.timestamps
      t.references :user
      t.references :course
    end
  end

  def self.down
    drop_table :course_users
  end
end
