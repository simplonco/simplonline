require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "create" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = user.id

    message = FactoryGirl.create(:message)
    post :create, message_id: message.id, comment: {content: 'some comment'}
    assert_redirected_to message_path(message)
    assert_equal 1, Comment.count
    assert_equal message, Comment.first.message
  end

  test "edit" do
    comment = FactoryGirl.create(:comment)
    user = comment.user
    session[:user_id] = user.id

    get :edit, id: comment.id, message_id: comment.message_id
    assert_response :success
    assert_equal comment, assigns(:comment)
    assert_equal comment.message, assigns(:message)
  end

  test "update" do
    comment = FactoryGirl.create(:comment)
    user = comment.user
    session[:user_id] = user.id
    post :update, message_id: comment.message.id, id: comment.id, comment: {content: 'new comment'}
    assert_redirected_to message_path(comment.message)
    assert_equal 1, Comment.count
    assert_equal 'new comment', comment.reload.content
  end

  test "destroy" do
    comment = FactoryGirl.create(:comment)
    user = comment.user
    session[:user_id] = user.id
    post :destroy, message_id: comment.message.id, id: comment.id
    assert_redirected_to message_path(comment.message)
    assert_equal 0, Comment.count
  end
end
