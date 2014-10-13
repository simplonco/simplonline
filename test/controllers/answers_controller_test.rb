require 'test_helper'

class AnswersControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "new" do
    question = FactoryGirl.create(:question)
    get :new, lesson_id: question.qcm.lesson.id, qcm_id: question.qcm.id, question_id: question.id
    assert_response :success
    assert_equal question, assigns(:question)
  end

  test "new without skipping question" do
    qcm = FactoryGirl.create(:qcm)
    first_question = FactoryGirl.create(:question, position: 1, qcm: qcm)
    second_question = FactoryGirl.create(:question, position: 2, qcm: qcm)
    get :new, lesson_id: qcm.lesson.id, qcm_id: qcm.id, question_id: second_question.id

    assert_redirected_to new_lesson_qcm_question_answer_path(qcm.lesson, qcm, first_question)
  end

  test "new response for next question when already answer to first" do
    qcm = FactoryGirl.create(:qcm)

    first_question = FactoryGirl.create(:question, position: 1, qcm: qcm)
    second_question = FactoryGirl.create(:question, position: 2, qcm: qcm)
    answer = FactoryGirl.create(:answer, user: @user, question: first_question, chosen_choices: [first_question.id])

    get :new, lesson_id: qcm.lesson.id, qcm_id: qcm.id, question_id: second_question.id
    assert_redirected_to new_lesson_qcm_question_answer_path(qcm.lesson, qcm, first_question)
  end

  test "create good choice" do
    question = FactoryGirl.create(:question)

    good_choice = FactoryGirl.create(:choice, question: question)
    bad_choice = FactoryGirl.create(:choice, question: question)

    qcm = question.qcm
    lesson = qcm.lesson

    post :create, lesson_id: lesson.id, qcm_id: qcm.id, question_id: question.id, answer: {good_choice.id => "1"}

    assert_equal 1, Answer.count
    assert_equal [good_choice.id], Answer.first.chosen_choices
    assert_equal @user, Answer.first.user

    assert_redirected_to lesson_qcm_question_result_path(question.qcm.lesson, question.qcm, question)
  end

  test "create no choise" do
    question = FactoryGirl.create(:question)
    good_choice = FactoryGirl.create(:choice, question: question)
    bad_choice = FactoryGirl.create(:choice, question: question)
    qcm = question.qcm
    lesson = qcm.lesson

    post :create, lesson_id: lesson.id, qcm_id: qcm.id, question_id: question.id, answer: nil

    assert_equal 1, Answer.count
    assert_redirected_to lesson_qcm_question_result_path(question.qcm.lesson, question.qcm, question)
  end

  test "create replace old answer" do
    question = FactoryGirl.create(:question)

    good_choice = FactoryGirl.create(:choice, question: question)
    bad_choice = FactoryGirl.create(:choice, question: question)

    existing_answer = FactoryGirl.create(:answer, user: @user, question: question, chosen_choices: [bad_choice.id])

    qcm = question.qcm
    lesson = qcm.lesson

    post :create, lesson_id: lesson.id, qcm_id: qcm.id, question_id: question.id, answer: {bad_choice.id => "1"}

    assert_equal 1, Answer.count
    assert_equal [bad_choice.id], Answer.first.chosen_choices
    assert_equal @user, Answer.first.user

    assert_redirected_to lesson_qcm_question_result_path(question.qcm.lesson, question.qcm, question)
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
