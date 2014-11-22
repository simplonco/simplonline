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

  test "cant create password" do
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

  test "edit redirect to welcome if user not found" do
    other_user = FactoryGirl.create(:user)
    user = FactoryGirl.create(:user, reset_password_key: '')

    get :edit, key: 'ekejlk34tkejrg'
    assert_redirected_to welcome_path
    assert_equal I18n.t('error.user_not_found'), flash[:error]
  end

  test "update" do
    user = FactoryGirl.create(:user, reset_password_key: 'somethingstrong')
    post :update, key: user.reset_password_key, password: 'newpass', password_confirmation: 'newpass'
    assert_redirected_to root_path
  end

  test "update cant be done because it's not the sane password" do
    user = FactoryGirl.create(:user, reset_password_key: 'somethingstrong')
    post :update, key: user.reset_password_key, password: 'newpass', password_confirmation: 'otherpass'
    assert_redirected_to edit_reset_password_path(key: user.reset_password_key)
    assert_equal ["Password confirmation #{I18n.t('activerecord.errors.models.user.attributes.password_confirmation.confirmation')}"], flash[:error]
  end

  test "update redirect to root when user not found" do
    user = FactoryGirl.create(:user, reset_password_key: 'somethingstrong')
    post :update, key: 'otherkey', password: 'newpass', password_confirmation: 'newpass'
    assert_redirected_to welcome_path
    assert_equal I18n.t('error.user_not_found'), flash[:error]
  end
end

