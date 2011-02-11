# Read about factories at http://github.com/thoughtbot/factory_girl
require 'lorem'

Factory.sequence :lorem do |n|
  lorem rand(100)+50
end

Factory.sequence :name do |n|
  lorem 3
end


Factory.define :course do |f|
  f.name {Factory.next :name}
  f.description {Factory.next :lorem}  # Three paragraphs
end
