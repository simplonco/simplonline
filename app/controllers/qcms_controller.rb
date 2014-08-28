class QcmsController < ApplicationController
  def show
    @qcm = Qcm.find(params[:id])
    @questions = @qcm.questions
  end

  def index
    @qcms = Qcm.all
  end

  def new
    @qcm = Qcm.new
  end

  def create
    @qcm = Qcm.create(qcm_params)
    redirect_to new_qcm_question_path @qcm.id
  end

  def edit
    @qcm = Qcm.find(params[:id])
  end

  def update
    @qcm = Qcm.find(params[:id])
    @qcm.update(qcm_params)
    redirect_to qcm_path(@qcm.id)
  end

  def delete
  end

  private
  
  def qcm_params
    params.require(:qcm).permit(:title, :desc)
  end
end
