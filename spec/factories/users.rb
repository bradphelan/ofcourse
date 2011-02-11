# Read about factories at http://github.com/thoughtbot/factory_girl

require 'lorem'

Factory.sequence :email do |n|
  "#{lorem}#{n}#{lorem}@#{lorem}.com"
end

Factory.define :user do |f|
  f.email { Factory.next :email }
  f.password 'testing'
  f.password_confirmation 'testing'
  #f.confirmed_at Time.now
end

Factory.define :admin, :class => User do |f|
  f.email 'admin@admin.com'
  f.password 'testing'
  f.password_confirmation 'testing'
  #f.confirmed_at Time.now
end
