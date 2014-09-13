require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  def setup
    @qcm = FactoryGirl.create(:qcm)
    user = FactoryGirl.create(:user)
    session[:user_id] = user.id
  end

  test "new" do
    qcm = FactoryGirl.create(:qcm)
    assert_not_nil qcm.lesson.id
    get :new, lesson_id: qcm.lesson.id, qcm_id: qcm.id
    assert_response :success
    assert_equal qcm, assigns(:qcm)
  end

  test "create" do
    post :create, lesson_id: @qcm.lesson.id, qcm_id: @qcm.id, question: {title: 'truc'}
    assert_response :redirect
  end

  test "delete" do
    question = FactoryGirl.create(:question)
    delete :destroy, lesson_id: question.id, qcm_id: question.qcm_id, id: question.id
    assert_response :redirect
  end

  test "edit" do
    question = FactoryGirl.create(:question)
    get :edit, lesson_id: @qcm.lesson.id, qcm_id: @qcm.id, id: question.id
    assert_response :success
    assert_equal question.qcm, assigns(:qcm)
  end

  test "post update" do
    question = FactoryGirl.create(:question)
    post :update, lesson_id: question.qcm.lesson.id, qcm_id: question.qcm_id, id: question.id, question: {title: 'truc'}
    assert_response :redirect
  end

end
