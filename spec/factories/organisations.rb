# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence :name do |n|
  "organisation #{n}"
end

Factory.define :organisation do |f|
  f.name Factory.next :name
end
