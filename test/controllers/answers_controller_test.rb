require 'test_helper'

class AnswersControllerTest < ActionController::TestCase

  def setup
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "new" do
    question = FactoryGirl.create(:question)
    assert_not_nil question.qcm.id
    assert_not_nil question.qcm.lesson.id
    get :new, lesson_id: question.qcm.lesson.id, qcm_id: question.qcm.id, question_id: question.id
    assert_response :success
    assert_equal question, assigns(:question)
  end

  test "create" do
    post :create, lesson_id: @question.qcm.lesson.id,
                  qcm_id: @question.qcm.id,
                  question_id: @question.id,
                  answer: {"4" => "1", "5" => "1", "6" => "1"}
    assert_redirected_to lesson_qcm_question_answer_path(@question.qcm.lesson, @question.qcm, @question, Answer.first)
    assert_equal 1, Answer.count
    assert_equal [4, 5, 6], Answer.first.chosen_choices
    assert_equal @user, Answer.first.user
  end

  test "show" do
    answer = FactoryGirl.create(:answer)
    question = answer.question
    get :show, lesson_id: question.qcm.lesson.id, qcm_id: question.qcm.id, question_id: question.id, id: answer.id
    assert_response :success
    assert_equal answer, assigns(:answer)
    assert_equal question, assigns(:question)
  end

end
