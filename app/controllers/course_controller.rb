class CourseController < ApplicationController
  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find params[:id]
  end

  def new
    @course = Course.new :date_of => Time.now, 
      :teacher => current_user, 
      :description => "Fill me in",
      :name => 'Your new course'

    @course.save
    redirect_to edit_course_path @course
  end

  def update
    #TODO protect against mass assignment
    @course = Course.find params[:id]
    @course.update_attributes params[:course]
    @course.save
    if @course.save
      flash[:success] = "Course updated"
      redirect_to edit_course_path(@course)              
    else
      flash[:error] = "Error"
      render :edit
    end
  end
end
