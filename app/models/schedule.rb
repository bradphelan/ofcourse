class Schedule < ActiveRecord::Base
  validates :start_date, :presence => true
  validates :end_date, :presence => true


  PERIOD = %w(weekly fortnightly monthly)
  validates :period, :presence => true,  :inclusion => {:in => PERIOD }

  # Course association
  belongs_to :course
  validates :course, :presence => true
  attr_readonly :course_id

  # Room association
  belongs_to :room
  validates :room, :presence => true

  DAYS = %w(monday tuesday wednesday thursday friday saturday sunday).map(&:to_sym)

  validates :duration, :presence => true


  def duration_in_hours
    duration / 60 / 60
  end

  before_save do
    # These columns are used for doing matching queries
    self.start_seconds_since_midnight = start_date.seconds_since_midnight
    self.end_seconds_since_midnight   = start_date.seconds_since_midnight + duration
  end

  validate :start_date do
    if start_date > end_date
      errors.add :end_date, "End time must be equal to or greater than start date"
    end
  end


  def has_coliding_events
    coliding_events.count != 0
  end

  # --
  # Return all coliding
  # events
  #
  def coliding_events
    cs = []

    # Id's of schedules with overlapping times of day
    pcsids = possibly_coliding_schedules.map &:id

    if pcsids.size == 0
      return []
    end

    e0 = Event.arel_table
    e1 = Event.arel_table.alias # because we do a self join

    # compare self events 
    j0 = e0[:schedule_id].eq(id)
    
    # and find events on the same dates
    j1 = e0[:event].eq(e1[:event])

    # whose times of day are overlapping
    j2 = e1[:schedule_id].in(pcsids)


    Event.joins(e1).where(
      j0.and(j1).and(j2)
    )

  end

  # --
  # Return all schedules on the same room that have overlapping 
  #   start_seconds_since_midnight
  #   end_seconds_since_midnight
  def possibly_coliding_schedules
    Schedule.where(possibly_coliding_schedules_query)
  end

  def possibly_coliding_schedules_query
    st = Schedule.arel_table

    # Only look in the same room
    rq = st[:room_id].eq(room_id)
    
    # Only look for schedules that
    # occupy the same time of day
    # slot
    oq = overlap_query \
      st[:start_seconds_since_midnight],
      st[:end_seconds_since_midnight],
      start_seconds_since_midnight,
      end_seconds_since_midnight,
      false


    # Exclude self
    if id
      idq = st[:id].not_eq(id)
    else
      idq = true
    end

    oq.and(rq).and(idq)

  end


  has_many :events

  after_save :refresh_events

  def refresh_events
    # Opening a transaction will speed
    # the insert of the data
    transaction do
      events.destroy_all
      ice = build_ice
      Rails.logger.debug ice.to_s
      ice.remaining_occurrences.each do |o|
        events.create! :event => o
      end
    end
  end

  def human_schedule
    build_ice.to_s
  end

  def build_ice
    require 'ice_cube'

    # Strip the time from the start_date
    seconds = start_date.seconds_since_midnight.seconds
    start_date_midnight = start_date - seconds

    s = IceCube::Schedule.new( start_date_midnight, :end_time => end_date.to_datetime + 1)

    days = DAYS.select do |day|
      self[day]
    end

    x = case period 
        when 'weekly'
          s.add_recurrence_rule IceCube::Rule.weekly(1).day(*days)
        when 'fortnightly'
          s.add_recurrence_rule IceCube::Rule.weekly(2).day(*days)
        when 'monthly'
          s.add_recurrence_rule IceCube::Rule.monthly(1).day(*days)
        end

    s

  end

  private

  # --
  # l0 < p0  && l1 > p0
  # l0 >= p0 && l1 <= p1
  # l0 < p1  && l1 > p1
  # --
  def overlap_query l0, l1, p0, p1, discrete

    if discrete
      t0 = l0.lteq(p0)   .and l1.gteq(p0)
      t1 = l0.gteq(p0) .and l1.lteq(p1)
      t2 = l0.lteq(p1)   .and l1.gteq(p1)
    else
      t0 = l0.lt(p0)   .and l1.gt(p0)
      t1 = l0.gteq(p0) .and l1.lteq(p1)
      t2 = l0.lt(p1)   .and l1.gt(p1)
    end

    t0.or(t1).or(t2)
  end

end
