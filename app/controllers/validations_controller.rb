class ValidationsController < ApplicationController

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.find(params[:chapter_id])
    submission = chapter.submissions.find(params[:submission_id])
    submission.add_validation_from(current_user, validation_params[:valid], validation_params[:comment])
    submission.save!
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  private

  def validation_params
    params.permit(:comment, :valid)
  end
end
