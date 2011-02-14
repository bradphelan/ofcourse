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

  # Schedule collision
  validate do

  end

  DAYS = %w(monday tuesday wednesday thursday friday saturday sunday) 

  validate do
    r = Schedule.where(overlap_query)
    if r.size == 0
      errors.add :base, "The following schedules [#{r.map(&:id).join(', ')}] are colliding" 
    end
  end

  def coliding_schedules_query
    schedule = Schedule.arel_table
    schedule[:monday].eq(true)
    
    # Do Times
    
    time_where = overlap_query \
          schedule[:start_time],
          schedule[:end_time],
          start_time,
          end_time

    # Do Dates

    date_where = overlap_query \
        schedule[:start_date],
        schedule[:end_date],
        start_date,
        end_date

    # Do room
    room_where = \
      schedule[:room_id].eq(room.id)

    days_where = DAYS.map(&:to_sym).map do |day|
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


  private

  def overlap_query field_lower, field_upper, p0, p1
    field_lower.lt(p0).and(field_upper.gt(p0)).
      or(  field_lower.gt(p0).and(field_upper.lt(p1))  ). 
      or(  field_lower.lt(p1).and(field_upper.gt(p1))  ) 
  end

end
