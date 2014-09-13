class StaticController < ApplicationController
  skip_filter :authenticate_user, only: [:welcome, :contact, :legal]

  def welcome
  end

  def contact
  end

  def legal
  end

  def dashboard
    @user = current_user
    @last_lessons = Lesson.last_lessons
  end
end
