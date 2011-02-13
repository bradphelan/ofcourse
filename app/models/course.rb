class Course < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User', :foreign_key => :user_id

  has_many :course_registrations
  has_many :students, :class_name => 'User', :through => :course_registrations, :source => :user
  has_many :schedules

  validates_presence_of :teacher
  validates_presence_of :description

  def description
    self[:description] || ""
  end

end
