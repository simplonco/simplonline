require 'test_helper'

class QcmsControllerTest < ActionController::TestCase

  attr_reader :user, :lesson

  def setup
    @lesson = FactoryGirl.create(:lesson)
  end

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "new" do
    setup_with(User::LOCAL)
    get :new, lesson_id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal [user], assigns(:available_authors)
  end

  test "can go to new when remote student" do
    setup_with(User::REMOTE)
    get :new, lesson_id: lesson.id
    assert_redirected_to root_path
  end

  test "create" do
    setup_with(User::LOCAL)
    post :create, lesson_id: lesson.id, qcm: {title: 'something', description: 'a ubber qcm from nowhere', author_ids: [user.id]}
    assert_redirected_to new_lesson_qcm_question_path(lesson, Qcm.first)
    assert_equal 1, Qcm.count
  end

  test "edit" do
    setup_with(User::LOCAL)
    qcm = FactoryGirl.create(:qcm, lesson: lesson)
    get :edit, lesson_id: lesson.id, id: qcm.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal qcm, assigns(:qcm)
    assert_equal [user], assigns(:available_authors)
  end

  test "update" do
    setup_with(User::LOCAL)
    qcm = FactoryGirl.create(:qcm, title: 'something', lesson: lesson)
    post :update, id: qcm.id, lesson_id: lesson.id, qcm: {title: 'other'}
    assert_redirected_to lesson_qcm_path(lesson, qcm)
    assert_equal 'other', qcm.reload.title
  end

  test "show" do
    setup_with(User::REMOTE)
    qcm = FactoryGirl.create(:qcm, lesson: lesson)
    get :show, lesson_id: lesson.id, id: qcm.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal qcm, assigns(:qcm)
  end
end
