class EventsController < ApplicationController

  # index
  def index
    @events = Event.find(:all, :conditions => ["start_at >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_at <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    events = [] 
    events = @events.map do |event|
      {
        :id => event.id, 
        :title => event.name, 
        :description => event.schedule.course.description || "Some cool description here...", 
        :start => "#{event.start_at.iso8601}", :end => "#{event.end_at.iso8601}", 
        :allDay => event.all_day, :recurring => true,
        :url => "admin/courses/edit/#{event.schedule.course.id}"
      }
    end
    render :text => events.to_json
  end
end
