require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  attr_reader :user

  def setup_with(student_type)
    if student_type.kind_of?(User)
      @user = student_type
    else
      @user = FactoryGirl.create(:user, student_type: student_type)
    end
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
    today = DateTime.new(2014,12,3,14,56)
    oldest_message = FactoryGirl.create(:message, updated_at: today - 1.day)
    message = FactoryGirl.create(:message, updated_at: today)
    get :index
    assert_response :success
    assert_equal [message, oldest_message], assigns(:messages)
  end

  test "show" do
    setup_with(User::REMOTE)
    message = FactoryGirl.create(:message)
    get :show, id: message.id
    assert_response :success
    assert_equal message, assigns(:message)
  end

  test "edit" do
    message = FactoryGirl.create(:message)
    setup_with(message.user)
    get :show, id: message.id
    assert_response :success
    assert_equal message, assigns(:message)
  end

  test "update" do
    message = FactoryGirl.create(:message, content: 'something')
    setup_with(message.user)
    assert_equal 1, Message.count
    post :update, id: message.id, message: {content: 'new content'}
    assert_redirected_to messages_path
    assert_equal 1, Message.count
    assert_equal 'new content', message.reload.content
  end

  test "delete" do
    message = FactoryGirl.create(:message, content: 'something')
    setup_with(message.user)
    post :destroy, id: message.id
    assert_redirected_to messages_path
    assert_equal 0, Message.count
  end
end
