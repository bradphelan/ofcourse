# Read about factories at http://github.com/thoughtbot/factory_girl

require 'lorem'

Factory.define :admin_role, :class => Role do |f|
  f.name 'admin'
  f.description 'Administrator'
end

Factory.define :user_role, :class => Role do |f|
  f.name 'user'
  f.description 'User'
end

def singleton name
    @@singletons ||= {}
    @@singletons[name] ||= Factory name
end

Factory.sequence :email do |n|
  "#{lorem}#{n}#{lorem}@#{lorem}.com"
end

Factory.define :user do |f|
  f.email { Factory.next :email }
  f.password 'testing'
  f.password_confirmation 'testing'
  f.after_build do |u|
    u.roles = [singleton(:user_role)]
  end
  #f.confirmed_at Time.now
end

Factory.define :admin, :parent => :user do |f|
  f.email 'admin@admin.com'
  f.after_build do |u|
    u.roles = [ singleton(:admin_role), singleton(:user_role)]
  end
  #f.confirmed_at Time.now
end
