require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "redirected to user dashboard when ok" do
    user = FactoryGirl.create(:user)
    post :create, email: user.email, password: user.password
    assert_redirected_to user_path(user)
  end

  test "redirected to home login when error" do
    post :create, email: 'nobody@something.com', password: 'a'
    assert_redirected_to root_path
    assert_equal 'User or password invalid', flash[:error]
  end
end

