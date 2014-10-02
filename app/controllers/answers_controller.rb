class AnswersController < ApplicationController
  skip_filter :remote_can_access

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
  end

  def create
    question = Question.find(params[:question_id])
    answer = question.answers.new
    answer.chosen_choices = params[:answer].keys.map{|id| id.to_i}
    answer.user = current_user
    first_unanswered_question = question.find_first_unanswered_question(question)
    if question.answers.empty?
      answer.save
    else
      redirect_to new_lesson_qcm_question_answer_path(question.qcm.lesson, question.qcm, first_unanswered_question)
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

end
