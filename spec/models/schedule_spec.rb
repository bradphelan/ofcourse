require 'spec_helper'

describe Schedule do

  before do
    @teach = Factory.create :user

    @course_1 = Factory.create :course, :teacher => @teach
    @course_2 = Factory.create :course, :teacher => @teach

    @room_0 = Room.create :name => '3a'

    @schedules = 2.times.map do 
      @course_1.schedules.build \
        :start_time => '10:00',
        :end_time   => '12:00',
        :start_date => Time.now,
        :end_date   => Time.now + 3.months,
        :room       => @room_0,
        :monday     => true,
        :wednesday  => true,
        :friday     => true,
        :period     => 'weekly'
        
    end
  end

  it "generates time overlap queries" do
    require 'pp'

    @schedules.each { |s| s.course_id.should_not be_nil }

    @schedules[0].id = 999
    pp @schedules[0].coliding_schedules_query.to_sql

    @schedules[0].save!
    lambda { @schedules[1].save! }.should raise_error
  end
end
