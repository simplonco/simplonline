require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
   test "true si la question a une réponse" do
     @question = Question.new(valid_answers: "6")
     assert_equal  true, @question.single_answer?
   end
   test "false si la question a deux choix" do
     @question = Question.new(valid_answers: "6, 2")
     assert_equal  false, @question.single_answer?
   end
end
