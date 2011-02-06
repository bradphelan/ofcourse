# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :course do |f|
  f.sequence :name do |n| 
    "course #{n}"
  end
end
