class ValidationsController < ApplicationController
  skip_filter :remote_cant_access

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.find(params[:chapter_id])
    submission = chapter.submissions.find(params[:submission_id])
    if current_user.can_validate_for?(chapter)
      submission.add_validation_from(current_user, validation_params[:valid], validation_params[:comment])
      submission.save!
    else
      flash[:error] = I18n.t('error.you_are_not_allowed_to_validate_submissions')
    end
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  private

  def validation_params
    params.permit(:comment, :valid)
  end
end
