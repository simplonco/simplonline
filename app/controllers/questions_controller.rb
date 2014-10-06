class QuestionsController < ApplicationController
  skip_filter :remote_cant_access, only: [:result]

  def new
    @qcm = Qcm.find(params[:qcm_id])
    @lesson = @qcm.lesson
    @question= @qcm.questions.new
  end

  def create
    @qcm = Qcm.find(params[:qcm_id])
    @lesson = @qcm.lesson
    @question = @qcm.questions.create(question_params.select{|k, v| k == "title"})
    @question.update(question_params)
    redirect_to lesson_qcm_path(@lesson, @qcm.id)
  end

  def destroy
    qcm = Qcm.find(params[:qcm_id])
    question = Question.find(params[:id])
    question.delete
    redirect_to lesson_qcm_path(qcm.lesson, qcm)
  end

  def edit
    @question = Question.find(params[:id])
    @qcm = @question.qcm
    @lesson = @qcm.lesson
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to lesson_qcm_path(@question.qcm.lesson_id, @question.qcm_id)
  end

  def result
    @question = Question.find(params[:question_id])
    @next_question = @question.next
    @qcm = @question.qcm
    @lesson = @qcm.lesson
    @answer = Answer.where(user: current_user, question: @question).first
    if @answer.is_valid?
      @result = I18n.t('questions.result.good_response')
    else
      @result = @question.tips
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :position, :tips, choices_attributes: [:id, :content, :explanation, :valid_answer, :_destroy])
  end

end
