class AnswersController < ApplicationController
  skip_filter :remote_cant_access

  def new
    @question = Question.find(params[:question_id])
    unless @question.answer_allowed?(current_user)
      redirect_to new_lesson_qcm_question_answer_path(@question.qcm.lesson, @question.qcm, @question.previous)
    end
    @answer = @question.answers.new
  end

  def create
    question = Question.find(params[:question_id])
    unless question.answer_allowed?(current_user)
      redirect_to lesson_qcm_question_result_path(question.qcm.lesson, question.qcm, question.previous)
    end
    answer = question.answers.where(user: current_user).first

    if answer.nil?
      answer = question.answers.new
    end

    param_answer = params[:answer]
    param_answer ||= {}
    answer.chosen_choices = param_answer.keys.map{|id| id.to_i}
    answer.user = current_user

    if answer.save
      redirect_to lesson_qcm_question_result_path(question.qcm.lesson, question.qcm, question)
    else
      flash[:error] = I18n.t('error.answer_not_save', errors: answer.errors.full_messages)
      redirect_to action: :new
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

end
