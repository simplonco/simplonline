class ChaptersController < ApplicationController

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @available_authors = User.all
  end

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.new(chapter_attributes)
    chapter.insert_definitions!
    chapter.save
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  def edit
    @chapter = Chapter.find(params[:id])
    @lesson = @chapter.lesson
    @available_authors = User.all
  end

  def update
    chapter = Chapter.find(params[:id])
    lesson = chapter.lesson
    chapter.update_attributes(chapter_attributes)
    chapter.save!
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  def show
    @chapter = Chapter.find(params[:id])
    @lesson = @chapter.lesson
  end

  private

  def chapter_attributes
    params.require(:chapter).permit(:title, :content, authors: [])
  end

end
