class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def new
  end

end
