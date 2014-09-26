require 'test_helper'

class ResetPasswordsControllerTest < ActionController::TestCase

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    post :create, email: 'me@somewhere.com'
    assert_redirected_to welcome_path
  end

  test "edit" do
    other_user = FactoryGirl.create(:user)
    user = FactoryGirl.create(:user, reset_password_key: 'something')
    get :edit, key: user.reset_password_key
    assert_response :success
    assert_equal user, assigns(:user)
  end

  test "update" do
    user = FactoryGirl.create(:user)
    post :update, user_id: user.id, password: 'newpass', password_confirmation: 'newpass'
    assert_redirected_to root_path
  end
end

