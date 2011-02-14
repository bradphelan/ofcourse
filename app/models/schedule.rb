class Schedule < ActiveRecord::Base
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validates :start_time, :presence => true
  validates :end_time, :presence => true

  PERIOD = %w(weekly fortnightly)
  validates :period, :presence => true,  :inclusion => {:in => PERIOD }

  validates :course, :presence => true

  belongs_to :course
  attr_readonly :course_id
end
