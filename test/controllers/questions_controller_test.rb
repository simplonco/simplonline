require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  attr_reader :qcm, :user, :lesson

  def setup
    @qcm = FactoryGirl.create(:qcm)
    @lesson = @qcm.lesson
    user = FactoryGirl.create(:user)
    session[:user_id] = user.id
  end

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "new" do
    setup_with(User::LOCAL)
    get :new, lesson_id: lesson.id, qcm_id: qcm.id
    assert_response :success
    assert_equal qcm, assigns(:qcm)
  end

  test "Remote student cant access to new" do
    setup_with(User::REMOTE)
    get :new, lesson_id: lesson.id, qcm_id: qcm.id
    assert_redirected_to root_path
  end

  test "create" do
    setup_with(User::LOCAL)
    post :create, lesson_id: lesson.id, qcm_id: qcm.id, question: {title: 'truc'}
    assert_response :redirect
  end

  test "delete" do
    setup_with(User::LOCAL)
    question = FactoryGirl.create(:question, qcm: qcm)
    delete :destroy, lesson_id: lesson.id, qcm_id: qcm.id, id: question.id
    assert_response :redirect
  end

  test "edit" do
    setup_with(User::LOCAL)
    question = FactoryGirl.create(:question, qcm: qcm)
    get :edit, lesson_id: lesson.id, qcm_id: qcm.id, id: question.id
    assert_response :success
    assert_equal question.qcm, assigns(:qcm)
  end

  test "post update" do
    setup_with(User::LOCAL)
    question = FactoryGirl.create(:question, qcm: qcm)
    post :update, lesson_id: lesson.id, qcm_id: qcm.id, id: question.id, question: {title: 'truc'}
    assert_response :redirect
  end

end
