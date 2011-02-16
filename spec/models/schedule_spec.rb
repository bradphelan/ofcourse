require 'spec_helper'

def time h, m
  t = Time.now
  t = t - t.seconds_since_midnight
  t = t + h.hours + m.minutes
end

describe Schedule do

  before do
    @teach = Factory.create :user

    @course_1 = Factory.create :course, :teacher => @teach
    @course_2 = Factory.create :course, :teacher => @teach
    @course_3 = Factory.create :course, :teacher => @teach

    @room_0 = Room.create :name => '3a'

    @sched_1 = @course_1.schedules.create \
      :start_date => time(12,0),
      :end_date => time(12,0) + 3.months,
      :duration   => 5.hours,
      :room       => @room_0,
      :monday     => true,
      :wednesday  => true,
      :friday     => true,
      :period     => 'weekly'
        

    @sched_2 = @course_2.schedules.create \
      :start_date => time(12,0),
      :end_date => time(12,0) + 3.months,
      :duration   => 5.hours,
      :room       => @room_0,
      :monday     => true,
      :wednesday  => true,
      :friday     => true,
      :period     => 'weekly'

    @sched_3 = @course_3.schedules.create \
      :start_date => time(12,0),
      :end_date => time(12,0) + 3.months,
      :duration   => 5.hours,
      :room       => @room_0,
      :monday     => true,
      :wednesday  => true,
      :friday     => true,
      :period     => 'weekly'
  end

        
  it "generates time overlap queries" do
    require 'pp'

    pp @sched_1
    pp @sched_2
    pp @sched_3

    @sched_1.coliding_events.count.should_not == 0
    @sched_2.coliding_events.count.should_not == 0
    @sched_3.coliding_events.count.should_not == 0

  end
end
