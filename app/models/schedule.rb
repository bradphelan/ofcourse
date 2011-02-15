class Schedule < ActiveRecord::Base
  validates :start_date, :presence => true
  validates :end_date, :presence => true


  PERIOD = %w(weekly fortnightly)
  validates :period, :presence => true,  :inclusion => {:in => PERIOD }

  # Course association
  belongs_to :course
  validates :course, :presence => true
  attr_readonly :course_id

  # Room association
  belongs_to :room
  validates :room, :presence => true

  DAYS = %w(monday tuesday wednesday thursday friday saturday sunday).map(&:to_sym)


#   validate do
#     if coliding_schedules.count != 0
#       errors.add :base, "The schedule overlaps with (an)other(s)" 
#     end
#   end

  validate :start_date do
    if start_date > end_date
      errors.add :end_date, "End time must be equal to or greater than start date"
    end
  end

  def has_coliding_schedules
    coliding_schedules.count != 0
  end

  def coliding_schedules
    Schedule.where(coliding_schedules_query)
  end

=begin
  def coliding_schedules_query
    schedule = Schedule.arel_table
    
    # Do Times
    
    # With time if there is a boundary on
    # which two dates co-inincide then overlap
    # is considered to be false.
    time_where = overlap_query \
          schedule[:start_time],
          schedule[:end_time],
          start_time,
          end_time,
          false

    # Do Dates
    # With dates if there is a boundary on
    # which two dates co-inincide then overlap
    # is considered to be true.

    date_where = overlap_query \
        schedule[:start_date],
        schedule[:end_date],
        start_date,
        end_date,
        true

    # Do room
    room_where = \
      schedule[:room_id].eq(room.id)

    days_where = DAYS.map do |day|
      if self[day]
        schedule[day].eq(true)
      else
        nil
      end
    end.select do |p|
      p
    end.inject do |pred, d|
      pred.or(d)
    end

    # Exclude self
    if id
      id_where = schedule[:id].not_eq(id)
    else
      id_where = true
    end


    room_where.and(date_where).and(time_where).and(days_where).and(id_where)

  end
=end

  has_many :events

  after_save :refresh_events

  def refresh_events
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
    s = IceCube::Schedule.new( start_date, :end_time => end_date.to_datetime)

    days = DAYS.select do |day|
      self[day]
    end

    x = if period == 'weekly'
          1
        else
          e
        end

    s.add_recurrence_rule IceCube::Rule.weekly(x).day(*days)

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
