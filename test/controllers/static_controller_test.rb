require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  test "welcome" do
    get :welcome
    assert_response :success
  end

  test "legal" do
    get :legal
    assert_response :success
  end

  test "contact" do
    get :contact
    assert_response :success
  end

  test "send contact" do
    post :send_contact, email: 'te@example.com', name: "tete", message: 'a message that contains chars'
    assert_redirected_to root_path
  end

  test "dashboard" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    online_lesson = FactoryGirl.create(:lesson, online: true)
    offline_lesson = FactoryGirl.create(:lesson, online: false)
    message = FactoryGirl.create(:message)
    session[:user_id] = user.id
    get :dashboard
    assert_response :success
    assert_not_nil assigns(:last_definitions)
    assert_equal [message], assigns(:last_messages)
    assert_equal [online_lesson], assigns(:last_lessons)
    assert_equal [], assigns(:your_submissions)
  end
end
