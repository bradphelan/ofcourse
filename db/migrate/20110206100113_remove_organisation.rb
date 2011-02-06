class RemoveOrganisation < ActiveRecord::Migration
  def self.up
    drop_table :organisations
    drop_table :organisation_memberships
    remove_column :courses, :organisation_id
  end

  def self.down
  end
end
