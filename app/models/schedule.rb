class Schedule < ActiveRecord::Base
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validates :start_time, :presence => true
  validates :end_time, :presence => true

  PERIOD = %w(weekly fortnightly)
  validates :period, :presence => true,  :inclusion => {:in => PERIOD }

  # Course association
  belongs_to :course
  validates :course, :presence => true
  attr_readonly :course_id

  # Room association
  belongs_to :room
  validates :room, :presence => true
end
