class Schedule < ActiveRecord::Base
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validates :start_time, :presence => true
  validates :end_time, :presence => true

  validates :period, :inclusion => {:in => %w(weekly fortnightly)}

  validates :course, :presence => true

  belongs_to :course
  attr_readonly :course_id
end
