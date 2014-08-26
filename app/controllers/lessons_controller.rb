class LessonsController < ApplicationController

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

  private

  def lesson_params
    params.require(:lesson).permit(:title)
  end
end
