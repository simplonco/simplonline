require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "create" do
    message = FactoryGirl.create(:message)
    post :create, message_id: message.id, comment: {content: 'some comment'}
    assert_redirected_to message_path(message)
    assert_equal 1, Comment.count
    assert_equal message, Comment.first.message
  end

end
