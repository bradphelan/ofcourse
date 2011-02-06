class RemoveForeignKeyFromCourseUsers < ActiveRecord::Migration
  def self.up
    remove_column :course_users, :id
  end

  def self.down
  end
end
