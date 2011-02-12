class CourseRegistration < ActiveRecord::Base

  belongs_to :course
  belongs_to :user

  # These join attributes should be immutable
  attr_readonly :course_id, :user_id

  validates_presence_of :course_id
  validates_presence_of :user_id

  MAXIMUM_COURSES = 5

  validate :on => :create do
    if user.course_registrations.size >= MAXIMUM_COURSES
      errors.add :user, "can only apply for #{MAXIMUM_COURSES} courses. Please remove one."
    end
  end

end
