require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    post :create, message: {title: 'A title', content: 'My question'}
    assert_redirected_to messages_path
    assert_equal 1, Message.count
  end

  test "index" do
    message = FactoryGirl.create(:message)
    get :index
    assert_response :success
    assert_equal [message], assigns(:messages)
  end

  test "show" do
    message = FactoryGirl.create(:message)
    get :show, id: message.id
    assert_response :success
    assert_equal message, assigns(:message)
  end
end
