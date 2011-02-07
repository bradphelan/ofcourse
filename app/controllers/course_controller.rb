class CourseController < ApplicationController
  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    #TODO protect against mass assignment
    @course = Course.find params[:id]
    @course.update_attributes params[:course]
    @course.save!
    redirect_to edit_course_path(@course)
  end
end
