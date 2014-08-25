require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  def setup
    @qcm = FactoryGirl.create(:qcm)
  end

  test "should get new" do
    question = FactoryGirl.create(:question)
    get :new, qcm_id: question.qcm_id, id: question.id
    assert_response :success
  end

  test "create" do
    post :create, qcm_id: @qcm.id, question: {title: 'truc'}
    assert_response :redirect
  end

  test "delete" do
    question = FactoryGirl.create(:question)
    delete :destroy, qcm_id: question.qcm_id, id: question.id
    assert_response :redirect
  end

  test "edit" do
    question = FactoryGirl.create(:question)
    get :edit, qcm_id: @qcm.id, id: question.id
    assert_response :success
  end

  test "post update" do
    question = FactoryGirl.create(:question)
    post :update, qcm_id: question.qcm_id, id: question.id, question: {title: 'truc'}
    assert_response :redirect
  end

end
