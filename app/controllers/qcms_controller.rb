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
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  
  def qcm_params
    params.require(:qcm).permit(:title,
                                :desc,
                                questions_attributes: [:id,
                                                       :title,
                                                       :desc,
                                                       :choix1,
                                                       :choix2,
                                                       :choix3,
                                                       :choix4,
                                                       :choix5,
                                                       :choix6,
                                                       :choix7,
                                                       :choix8,
                                                       :choix9,
                                                       :valid_answers,
                                                       :_destroy,
                                ])
  end
end
