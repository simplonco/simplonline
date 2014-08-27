require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "redirected to user dashboard when ok" do
    user = FactoryGirl.create(:user)
    post :create, email: user.email, password: user.password
    assert_redirected_to root_path
  end

  test "redirected to login page when error" do
    post :create, email: 'nobody@something.com', password: 'a'
    assert_redirected_to welcome_path
    assert_equal 'User or password invalid', flash[:error]
  end
end

