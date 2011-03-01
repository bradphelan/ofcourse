# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence :room_name do |n|
  "R#{n}"
end

Factory.define :room do |f|
  f.name { Factory.next :room_name }
end
