require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "create" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = user.id

    message = FactoryGirl.create(:message)

    post :create, message_id: message.id, message: {content: 'some comment'}
    assert_equal 2, Message.count
    message.reload
    response = message.responses.first
    assert_redirected_to message_path(message, anchor: response)
    assert_equal 'some comment', response.content
    assert_equal user, response.user
  end

end
