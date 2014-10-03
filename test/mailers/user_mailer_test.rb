require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "reset password" do
    user = FactoryGirl.create(:user, email: 'tu@grrr.com')
    email = UserMailer.reset_password(user).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['foad@simplon.co'], email.from
    assert_equal [user.email], email.to
    assert_equal I18n.t('user_mailer.reset_password.subject'), email.subject
    assert email.body.include?(user.name)
  end

  test "contact" do
    user = FactoryGirl.create(:user, email: 'tu@grrr.com')
    message = "someting to say"

    email = UserMailer.contact(user.email, user.name, message).deliver

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['foad@simplon.co'], email.to
    assert_equal [user.email], email.from
    assert_equal I18n.t('user_mailer.contact.subject'), email.subject
    assert email.body.include?(message)
  end


end
