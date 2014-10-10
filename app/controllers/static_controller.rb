class StaticController < ApplicationController
  skip_filter :authenticate_user, only: [:welcome, :contact, :legal, :send_contact]
  skip_filter :remote_cant_access

  def welcome
  end

  def contact
  end

  def send_contact
    UserMailer.contact(params[:email], params[:name], params[:message]).deliver
    redirect_to root_path
  end

  def legal
  end

  def dashboard
    @user = current_user
    @last_lessons = Lesson.last_lessons
    @last_definitions = Definition.last_updated
    @last_messages = Message.recent
    @your_submissions = Submission.where(user: current_user)
  end
end
