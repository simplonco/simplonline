require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "show" do
    user = FactoryGirl.create(:user)
    session[:user_id] = user.id
    get :show, id: user.id
    assert_response :success
    assert_equal user, assigns(:user)
  end

  test "show redirect to login when no logged user" do
    user = FactoryGirl.create(:user)
    get :show, id: user.id
    assert_redirected_to welcome_path
  end

end
