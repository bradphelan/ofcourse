class Course < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User', :foreign_key => :user_id

  has_and_belongs_to_many :students, :class_name => 'User', :join_table => :courses_users

  validates_presence_of :teacher
  validates_presence_of :description

  def description
    self[:description] || ""
  end
end
