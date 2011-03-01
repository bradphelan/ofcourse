class EventsController < ApplicationController

  class CssGenerator
    def initialize
      @numbers = {}
    end 

    def class_for name
      @numbers[name] ||= "cal-event-#{@numbers.size}"
    end
  end

  # index
  def index
    render :text => events.to_json
  end

  private
  
  def events

    cssgen = CssGenerator.new

    events_query.map do |event|

      {
        :id => event.id, 
        :title => event.name, 
        :description => event.schedule.course.description || "Some cool description here...", 
        :start => "#{event.start_at.iso8601}", :end => "#{event.end_at.iso8601}", 
        :allDay => event.all_day, :recurring => true,
        :url => "admin/courses/edit/#{event.schedule.course.id}",
        :className => cssgen.class_for(event.name),
        :editable => false,
      }
    end
  end

  def gen_css_class name
    "cal-event-#{name.hash % 10}"
  end

  def events_query
    Event.where \
      "start_at >= :start_at and end_at <= :end_at",
      :start_at => time_param_format('start'),
      :end_at => time_param_format('end')
  end

  def time_param_format(p)
    time_format(params[p].to_i)
  end

  def time_format(p)
    Time.at(p).to_formatted_s(:db)
  end

end
