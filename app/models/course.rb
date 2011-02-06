class Course < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :teacher, :class_name => 'User', :foreign_key => :user_id

  validates_presence_of :organisation
  validates_presence_of :teacher
end
