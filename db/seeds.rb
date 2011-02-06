# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'factory_girl'
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

10.times do
  o = Factory.create :organisation

  10.times do
    o.users << Factory.create(:user)
  end

end
