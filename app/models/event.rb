class Event < ActiveRecord::Base
  belongs_to :schedule
  validates :schedule, :presence => true

  # TODO validate date format
  validates :event, :presence => true
end
