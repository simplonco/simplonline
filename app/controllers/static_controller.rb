class StaticController < ApplicationController
  skip_filter :authenticate_user, only: [:welcome, :contact, :legal]
  skip_filter :remote_can_access

  def welcome
  end

  def contact
  end

  def legal
  end

  def dashboard
    @user = current_user
    @last_lessons = Lesson.last_lessons
    @last_definitions = Definition.last_updated
    @last_messages = Message.recent
  end
end
