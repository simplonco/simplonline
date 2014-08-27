class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
    @answer.chosen_choices = params[:answer].keys.join(', ')
    @answer.user = current_user
    @answer.save
    redirect_to qcm_question_answer_path(@question.qcm.id, @question.id, @answer.id)
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end
end
