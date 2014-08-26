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

end
