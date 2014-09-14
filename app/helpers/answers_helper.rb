module AnswersHelper

def class_chosen(answer, choice)
  "chosen" if answer.chosen_choices.include?(choice.id) 
end

def class_valid(choice)
  "valid" if choice.valid_answer == true
end

def link_to_next(lesson_id, qcm_id, question_id, question_ids)
  next_id = question_ids.reject{ |id| id <= question_id }.first

  if not next_id.blank?
    link_to "Question suivante", new_lesson_qcm_question_answer_path(lesson_id, qcm_id, next_id)
  else
    link_to "Terminer", lesson_qcm_path(lesson_id, qcm_id)
  end
end

end
