require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "show" do
    user = FactoryGirl.create(:user)
    last_lessons = [FactoryGirl.create(:lesson)]
    session[:user_id] = user.id
    get :show, id: user.id
    assert_response :success
    assert_equal user, assigns(:user)
    assert_equal last_lessons, assigns(:last_lessons)
  end

  test "show redirect to login when no logged user" do
    user = FactoryGirl.create(:user)
    get :show, id: user.id
    assert_redirected_to welcome_path
  end

end
