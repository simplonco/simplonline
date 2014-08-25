class QuestionsController < ApplicationController
  def new
    @qcm = Qcm.find(params[:qcm_id])
    @question= @qcm.questions.new
  end

  def create
    @qcm = Qcm.find(params[:qcm_id])
    @question = @qcm.questions.create(question_params)
  end

  def delete
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
  end

  private
  def question_params
    params.require(:question).permit(:title, choices_attributes: [:id, :content, :valid_answer, :_destroy]) 
  end
end
