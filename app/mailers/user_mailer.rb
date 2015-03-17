class UserMailer < ActionMailer::Base
  default from: "foad@simplon.co"

  def reset_password(user)
    @url = 'truc'
    @user = user
    mail(to: @user.email, subject: t('.subject'))
  end

  def contact(email, name, message)
    @url = 'truc'
    @email = email
    @name = name
    @message = message
    mail(to: 'foad@simplon.co', from: @email, subject: t('.subject'))
  end

  def message_post_notification(user, message)
    @user = user
    @message = message
    mail(to: "#{user.email}", subject: "New post in #{message.title}")
  end

  def reminder_to_inactive_users(user)
    @user = user
    mail(to: @user.email, subject: t('.subject'))
  end
end
