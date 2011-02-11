# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'factory_girl'
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}


courses = 15.times.map do
  teacher = Factory.create :user
  Factory.create(:course, :teacher => teacher) 
end

15.times do |i|
  u = Factory.create(:user)
  u.courses << courses[i%3]
end


Factory.create :admin
 
  

