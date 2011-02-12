require 'devise'

require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    filter_access_to :all
  end


end

RailsAdmin.config do |config|
  config.model CourseRegistration do
    hide_from_navigation
  end

  config.model Ckeditor::Asset do
    hide_from_navigation
  end

  config.model Ckeditor::AttachmentFile do
    hide_from_navigation
  end

  config.model Ckeditor::Picture do
    hide_from_navigation
  end

  config.model User do
    edit do
      group :default do
        field :email
        field :password
        field :password_confirmation
        field :courses
        field :presentations
      end
      group :to_hide do
        label "To Hide"
        field :course_registrations
        hide
      end
    end
  end

  config.model Course do
    edit do
      group :default do
        field :name
        field :description, :text do
          ckeditor do
            true
          end
        end
        field :date_of
        field :students
      end
      group :to_hide do
        label "To Hide"
        field :course_registrations
        hide
      end
    end
  end

end

