class LessonsController < ApplicationController
  before_filter :remote_can_access, except: [:index, :show]

  def index
    @lessons = Lesson.all
  end

  def new
  end

  def create
    lesson = Lesson.new(lesson_params)
    lesson.save!
    redirect_to action: :index
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def update
    lesson = Lesson.find(params[:id])
    lesson.update_attributes(lesson_params)
    lesson.save!
    redirect_to lesson_path(lesson)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :online, :description)
  end

  def remote_can_access
    redirect_to root_path if current_user.remote?
  end
end
