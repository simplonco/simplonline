class QuestionsController < ApplicationController
  def new
    @qcm = Qcm.find(params[:qcm_id])
    @question= @qcm.questions.new
  end

  def create
    @qcm = Qcm.find(params[:qcm_id])
    @question = @qcm.questions.create(question_params)
    redirect_to qcm_path(@question.qcm_id)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.delete
    redirect_to qcm_path(params[:qcm_id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to qcm_path(@question.qcm_id)
  end

  private
  def question_params
    params.require(:question).permit(:title, choices_attributes: [:id, :content, :valid_answer, :_destroy]) 
  end
end
