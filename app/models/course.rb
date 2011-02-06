class Course < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :teacher, :class_name => 'User', :foreign_key => :user_id

  has_and_belongs_to_many :students, :class_name => 'User', :join_table => :course_users

  validates_presence_of :organisation
  validates_presence_of :teacher
end
