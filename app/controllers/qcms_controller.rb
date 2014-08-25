class QcmsController < ApplicationController
  def show

  end

  def index
  end

  def new
    @qcm = Qcm.new
  end

  def create
    @qcm = Qcm.create(qcm_params)
    redirect_to new_qcm_question_path @qcm.id
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  
  def qcm_params
    params.require(:qcm).permit(:title, :desc)
  end
end
