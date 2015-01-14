class ChaptersController < ApplicationController

  def index
    @chapters = Chapter.search(params[:search])
    @all_chapters = Chapter.all
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
    set_available_data
  end

  def create
    lesson = Lesson.find(params[:lesson_id])
    chapter = lesson.chapters.new(chapter_attributes)
    chapter.save!
    redirect_to lesson_chapter_path(lesson, chapter)
  end

  def edit
    @chapter = Chapter.find(params[:id])
    @lesson = @chapter.lesson
    set_available_data
  end

  def update
    chapter = Chapter.find(params[:id])
    lesson = chapter.lesson
    chapter.update_attributes(chapter_attributes)
    if chapter.save
      redirect_to lesson_chapter_path(lesson, chapter)
    else
      flash[:error] = mon,erreur
      redirect_to edit_lesson_chapter_path(lesson, chapter)
    end
  end

  def show
    @lesson = Lesson.find(params[:lesson_id])
    @chapter = @lesson.chapters.find(params[:id])
    if current_user.remote? && @lesson.offline?
      flash[:error] = t('.not_found')
      redirect_to root_path
    end
  end

  private

  def set_available_data
    @available_authors = User.authors
    @available_tags = I18n.t(:tags)
    @available_categories = I18n.t(:categories)
  end

  def chapter_attributes
    params.require(:chapter).permit(:title, :content, :number, :ask_pair_validation, :category, tags: [], author_ids: [])
  end

end
