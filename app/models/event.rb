require 'event_calendar'
class Event < ActiveRecord::Base
  belongs_to :schedule
  validates :schedule, :presence => true

  has_event_calendar


  # TODO validate date format
  validates :start_at, :presence => true
  validates :end_at, :presence => true
  validates :name, :presence => true
end
