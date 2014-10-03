require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  test "have a valid factory" do
    assert FactoryGirl.build(:question).valid?
  end

  test "invalid without qcm" do
    assert FactoryGirl.build(:question, qcm: nil).invalid?
  end

  test "no valid_answers when no choices" do
    question = FactoryGirl.create(:question)
    assert_equal 0, question.valid_answers.count
  end

  test "one valid_answers when one choice" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    assert_equal 1, question.valid_answers.count
  end

  test "two valid_answers when two choices" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    assert_equal 2, question.valid_answers.count
  end

  test "valid_answers count only valid choices" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    FactoryGirl.create(:choice, valid_answer: false, question: question)
    assert_equal 1, question.valid_answers.count
  end

  test "true si la question a une réponse" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: false, question: question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    FactoryGirl.create(:choice, valid_answer: false, question: question)
    assert question.single_answer?
  end

  test "false si la question a deux choix" do
    question = FactoryGirl.create(:question)
    Choice.new(valid_answer: true, question: question)
    Choice.new(valid_answer: true, question: question)
    Choice.new(valid_answer: false, question: question)
    assert ! question.single_answer?
  end

  test "next" do
    question = FactoryGirl.create(:question, position: 1)
    next_question = FactoryGirl.create(:question, qcm: question.qcm, position: 2)
    assert_equal next_question, question.next
  end

  test "previous" do
    qcm = FactoryGirl.create(:qcm)
    previous_previous_question = FactoryGirl.create(:question, position: 0, qcm: qcm)
    previous_question = FactoryGirl.create(:question, position: 1, qcm:qcm)
    question = FactoryGirl.create(:question, qcm: qcm, position: 2)
    assert_equal previous_question, question.previous
  end

  test "answer allowed when no previous question" do
    user = FactoryGirl.create(:user)
    qcm = FactoryGirl.create(:qcm)
    question = FactoryGirl.create(:question, qcm: qcm)
    assert question.answer_allowed?(user), 'answer should be allowed when no previous question'
  end

  test "answer not allowed when previous question without good answer" do
    user = FactoryGirl.create(:user)
    qcm = FactoryGirl.create(:qcm)

    first_question = FactoryGirl.create(:question, qcm: qcm, position: 1)
    good_choice = FactoryGirl.create(:choice, question: first_question, valid_answer: true)
    bad_choice = FactoryGirl.create(:choice, question: first_question)
    answer = FactoryGirl.create(:answer, user: user, question: first_question, chosen_choices: [bad_choice.id])

    second_question = FactoryGirl.create(:question, qcm: qcm, position:2)

    assert ! second_question.answer_allowed?(user), 'answer should be not allowed when previous question have no valid answer'
  end

end
