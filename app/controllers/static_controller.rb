class StaticController < ApplicationController
  skip_filter :authenticate_user, only: [:welcome, :contact, :legal, :send_contact]
  skip_filter :remote_cant_access

  def welcome
  end

  def contact
  end

  def send_contact
    if params[:message] && params[:message].present?
      UserMailer.contact(params[:email], params[:name], params[:message]).deliver
      redirect_to root_path
    else
      flash[:error] = I18n.t('error.message_missing')
      redirect_to contact_path
    end
  end

  def legal
  end

  def dashboard
    @user = current_user
    @last_lessons = Lesson.last_lessons.limit(6)
    @last_definitions = Definition.last_updated
    @last_messages = Message.recent.page(1).per(10)
    if current_user.remote?
      @submissions = Submission.where(user: current_user)
    else
      @submissions = Submission.to_validate(current_user)
    end
  end
end
