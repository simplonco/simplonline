require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  attr_reader :user

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "new can be access by local student" do
    setup_with(User::LOCAL)
    get :new
    assert_response :success
  end

  test "new can be access by remote student" do
    setup_with(User::REMOTE)
    get :new
    assert_response :success
  end

  test "create" do
    setup_with(User::REMOTE)
    post :create, message: {title: 'A title', content: 'My question'}
    assert_redirected_to messages_path
    assert_equal 1, Message.count
  end

  test "index" do
    setup_with(User::REMOTE)
    message = FactoryGirl.create(:message)
    get :index
    assert_response :success
    assert_equal [message], assigns(:messages)
  end

  test "show" do
    setup_with(User::REMOTE)
    message = FactoryGirl.create(:message)
    get :show, id: message.id
    assert_response :success
    assert_equal message, assigns(:message)
  end
end
