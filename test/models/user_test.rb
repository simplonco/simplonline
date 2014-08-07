require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid factory" do
    assert_equal true, FactoryGirl.build(:user).valid?
  end

  test "check email and password on login" do
    user = FactoryGirl.create(:user, password: 'something', password_confirmation: 'something')
    assert_equal user, User.find_by(user.email).authenticate('something')
    assert User.login(user.email, 'something'), 'login with email and password fail'
  end

  test "password" do
    user = FactoryGirl.create(:user, password: 'something clear', password_confirmation: 'something clear')
    assert_not_equal 'something clear', user.password_digest
  end
end
