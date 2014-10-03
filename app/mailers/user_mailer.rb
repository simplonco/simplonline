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


end
