# Read about factories at http://github.com/thoughtbot/factory_girl

User.delete_all
Organisation.delete_all

Factory.sequence :email do |n|
  "somebody#{n}@example.com"
end

Factory.define :user do |f|
  f.email { Factory.next :email }
  f.password 'testing'
  f.password_confirmation 'testing'
end
