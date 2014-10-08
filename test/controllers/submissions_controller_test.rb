require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = @user.id
  end

  test "create" do
    chapter = FactoryGirl.create(:chapter)
    lesson = chapter.lesson
    post :create, lesson_id: lesson.id, chapter_id: chapter.id, submission: {content: 'Something to try'}
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert_equal 1, Submission.count
    assert_equal user, Submission.first.user
    assert_equal chapter, Submission.first.chapter
  end

  test "edit" do
    submission = FactoryGirl.create(:submission, user: user)
    chapter = submission.chapter
    lesson = chapter.lesson
    get :edit, lesson_id: lesson.id, chapter_id: chapter.id, id: submission.id
    assert_response :success
    assert_equal chapter, assigns(:chapter)
    assert_equal lesson, assigns(:lesson)
    assert_equal submission, assigns(:submission)
  end

  test "update" do
    submission = FactoryGirl.create(:submission, user: user)
    chapter = submission.chapter
    lesson = chapter.lesson
    post :update, lesson_id: lesson.id, chapter_id: chapter.id, id: submission.id, submission: {content: 'New content'}
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert_equal 'New content', submission.reload.content
  end
end
