require 'spec_helper'

describe Schedule do

  before do
    @course_1 = Course.create
    @course_2 = Course.create

    @room_0 = Room.create :name => '3a'

    @schedule = @course_1.schedules.build \
      :start_time => '10:00',
      :end_time   => '12:00',
      :start_date => Time.now,
      :end_date   => Time.now + 3.months,
      :room       => @room_0,
      :monday     => true,
      :wednesday  => true,
      :friday     => true
  end

  it "generates time overlap queries" do
    require 'pp'
    @schedule.id = 999
    rel = @schedule.coliding_schedules_query
    pp rel.to_sql
  end
end
