require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid factory" do
    assert_equal true, FactoryGirl.build(:user).valid?
  end

  test "invalid without nom" do
    assert_equal true, FactoryGirl.build(:user, name: nil).invalid?
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

  test "remote? true when remote student" do
    user = FactoryGirl.create(:user, remote: true)
    assert user.remote?
  end

  test "remote? false when remote student" do
    user = FactoryGirl.create(:user, remote: false)
    assert ! user.remote?
  end

  test "local? true when presential student" do
    user = FactoryGirl.create(:user, remote: false)
    assert user.local?
  end

  test "local? false when presential student" do
    user = FactoryGirl.create(:user, remote: true)
    assert ! user.local?
  end

  test "generate reset_password_key!" do
    user = FactoryGirl.create(:user, reset_password_key: nil)
    user.generate_reset_password_key!
    assert_not_nil user.reset_password_key
  end
end
