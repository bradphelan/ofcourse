class Organisation < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :organisation_memberships
  has_many :courses
end
