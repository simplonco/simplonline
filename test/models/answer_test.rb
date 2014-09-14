require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  test "have a valid factory" do
    assert FactoryGirl.build(:answer).valid?
  end

  test "invalid without user" do
    assert FactoryGirl.build(:answer, user: nil).invalid?
  end

  test "invalid without question" do
    assert FactoryGirl.build(:answer, question: nil).invalid?
  end

  test "valid if question with one valid choice" do
    question = FactoryGirl.create(:question)
    choice = FactoryGirl.create(:choice, valid_answer: true, question: question)
    answer = FactoryGirl.create(:answer, chosen_choices: [choice.id], question: question)
    assert_equal true, answer.is_valid?
  end

  test "invalid if answer incomplete" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    FactoryGirl.create(:choice, valid_answer: true, question: question)
    answer = FactoryGirl.create(:answer, chosen_choices: [2], question: question)
    assert ! answer.is_valid?
  end

  test "valid for a question with one invalid choice amongs 2" do
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:choice, valid_answer: false, question: question)
    choice = FactoryGirl.create(:choice, valid_answer: true, question: question)
    answer = FactoryGirl.create(:answer, chosen_choices: [choice.id], question: question)
    assert answer.is_valid?
  end
end
