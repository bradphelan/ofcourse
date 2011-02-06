class RemoveOrganisation < ActiveRecord::Migration
  def self.up
    drop_table :organisations
    drop_table :organisation_memberships
    remove_column :courses, :organisation_id
    rename_table :course_users, :courses_users
  end

  def self.down
  end
end
