class UserMailer < ActionMailer::Base
  default from: "foad@simplon.co"

  def reset_password(user)
    @url = 'truc'
    @user = user
    mail(to: @user.email, subject: t('.subject'))
  end

end
