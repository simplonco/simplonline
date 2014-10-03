module LessonsHelper
  def link_to_next(lesson_id, lesson_ids)
  next_id = lesson_ids.pluck(:id).reject{ |id| id <= lesson_id }.first

    if not next_id.blank?
      link_to t('next_lesson'), lesson_path(next_id)
    else
    end
  end
end