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
    answer.save
    redirect_to lesson_qcm_question_answer_path(question.qcm.lesson, question.qcm, question, answer)
  end

  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

end
