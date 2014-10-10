require 'test_helper'

class ValidationsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "create" do
    submission = FactoryGirl.create(:submission)
    chapter = submission.chapter
    lesson = chapter.lesson
    post :create, lesson_id: lesson.id, chapter_id: chapter.id, submission_id: submission.id, valid: true, comment: 'Yeah \o/'
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert submission.reload.first_validation_status, 'Should have a true status'
    assert_equal user, submission.reload.first_validation_user
  end
end
