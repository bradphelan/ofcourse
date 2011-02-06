class CreateOrganisationMemberships < ActiveRecord::Migration
  def self.up
    create_table :organisation_memberships, :id => false do |t|
      t.references :user
      t.references :organisation
    end
  end

  def self.down
    drop_table :organisation_memberships
  end
end
