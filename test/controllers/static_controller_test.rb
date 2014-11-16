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

  test "about" do
    get :about
    assert_response :success
  end

  test "send message" do
    post :send_contact, email: 'te@example.com', name: "tete", message: 'a message that contains chars'
    assert_redirected_to root_path
    assert_nil flash[:error]
  end

  test "dont send message without text" do
    post :send_contact, email: 'te@example.com', name: "tete"
    assert_redirected_to contact_path
    assert_equal I18n.t('error.message_missing'), flash[:error]
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
    assert_equal [], assigns(:submissions)
  end

  test "dashboard about submission for local user" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    chapter = FactoryGirl.create(:chapter, ask_pair_validation: true)
    session[:user_id] = user.id

    validated_submission = FactoryGirl.create(:submission, first_validation_user: FactoryGirl.create(:user), second_validation_user: FactoryGirl.create(:user), chapter: chapter)
    to_validate_submission = FactoryGirl.create(:submission, chapter: chapter)

    get :dashboard
    assert_response :success
    assert_equal [to_validate_submission], assigns(:submissions)
  end

  test "dashboard about submission for remote user" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = user.id

    local_submission = FactoryGirl.create(:submission, user: user)
    other_submission = FactoryGirl.create(:submission)

    get :dashboard
    assert_response :success
    assert_equal [local_submission], assigns(:submissions)
  end

  test "dashboard about show max lessons" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = user.id

    7.times do
      FactoryGirl.create(:lesson, online: true)
    end
    get :dashboard
    assert_response :success
    assert_equal 6, assigns(:last_lessons).count
  end

end
