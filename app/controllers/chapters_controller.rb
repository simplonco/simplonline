class ChaptersController < ApplicationController

  def new
    @lesson = Lesson.find(params[:lesson_id])
  end

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.create(chapter_attributes)
    chapter.save!
    redirect_to edit_lesson_path(lesson)
  end

  def edit
    @chapter = Chapter.find(params[:id])
    @lesson = @chapter.lesson
  end

  def update
    chapter = Chapter.find(params[:id])
    lesson = chapter.lesson
    chapter.update_attributes(chapter_attributes)
    chapter.save!
    redirect_to lesson_chapter_path(chapter, lesson)
  end

  def show
    @chapter = Chapter.find(params[:id])
    @lesson = @chapter.lesson
  end

  private

  def chapter_attributes
    params.require(:chapter).permit(:title, :content)
  end

end
