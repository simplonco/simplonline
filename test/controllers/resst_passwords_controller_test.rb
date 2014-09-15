require 'test_helper'

class ResetPasswordsControllerTest < ActionController::TestCase

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    post :create
    assert_redirected_to welcome_path
    # email sent
  end

  test "edit" do
    user = FactoryGirl.create(:user)
    get :edit
    assert_response :success
    assert_equal user, assigns(:user)
  end

  test "update" do
    post :update
    assert_redirected_to root_path
  end
end

