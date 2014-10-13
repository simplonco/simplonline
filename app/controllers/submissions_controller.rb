class SubmissionsController < ApplicationController
  skip_filter :remote_cant_access

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.find(params[:chapter_id])
    submission = chapter.submissions.new(submission_params)
    submission.user = current_user
    submission.save!
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  def edit
    @lesson = Lesson.find(params[:lesson_id])
    @chapter = @lesson.chapters.find(params[:chapter_id])
    @submission = @chapter.user_submission(current_user)
  end

  def update
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.find(params[:chapter_id])
    submission = chapter.user_submission(current_user)
    submission.update_attributes(submission_params)
    submission.save!
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  def show
    @lesson = Lesson.find(params[:lesson_id])
    @chapter = @lesson.chapters.find(params[:chapter_id])
    @submission = @chapter.submissions.find(params[:id])
  end

  private

  def submission_params
    params.require(:submission).permit(:content)
  end

end
