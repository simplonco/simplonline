class QcmsController < ApplicationController
  def show
    @qcm = Qcm.find(params[:id])
    @lesson = @qcm.lesson
    @questions = @qcm.questions
  end

  def index
    @qcms = Qcm.all
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
  end

  def create
    lesson = Lesson.find(params[:lesson_id])
    qcm = lesson.qcms.new
    qcm.update_attributes(qcm_params)
    qcm.save!
    redirect_to new_lesson_qcm_question_path(lesson, qcm)
  end

  def edit
    @qcm = Qcm.find(params[:id])
    @lesson = @qcm.lesson
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
