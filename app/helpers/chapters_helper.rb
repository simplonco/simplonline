module ChaptersHelper
  def link_to_next_chapter(lesson_id, chapter_id, chapter_ids)
    next_id = chapter_ids.reject{ |id| id <= chapter_id }.first

    if not next_id.blank?
      link_to t('next_chapter'), lesson_chapter_path(lesson_id, next_id)
    else
    end
  end
end