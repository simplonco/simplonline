require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "reset password" do
    user = FactoryGirl.create(:user, email: 'tu@grrr.com')
    email = UserMailer.reset_password(user).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['from@example.com'], email.from
    assert_equal ['tu@grrr.com'], email.to
    assert_equal 'Welcome to My Awesome Site', email.subject
  end

end
