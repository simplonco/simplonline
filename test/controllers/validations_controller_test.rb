require 'test_helper'

class ValidationsControllerTest < ActionController::TestCase

  test "create" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = user.id
    submission = FactoryGirl.create(:submission)
    chapter = submission.chapter
    lesson = chapter.lesson
    post :create, lesson_id: lesson.id, chapter_id: chapter.id, submission_id: submission.id, valid: true, comment: 'Yeah \o/'
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert submission.reload.first_validation_status, 'Should have a true status'
    assert_equal user, submission.reload.first_validation_user
  end

  test "cant create with a remote user that not allowed" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    session[:user_id] = user.id

    submission = FactoryGirl.create(:submission)
    chapter = submission.chapter

    self_submission = FactoryGirl.create(:submission, user: user, chapter: chapter, first_validation_status: false)

    lesson = chapter.lesson
    post :create, lesson_id: lesson.id, chapter_id: chapter.id, submission_id: submission.id, valid: true, comment: 'Yeah \o/'
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert_equal I18n.t('error.you_are_not_allowed_to_validate_submissions'), flash[:error]
  end

end
