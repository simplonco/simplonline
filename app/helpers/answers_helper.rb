module AnswersHelper

def class_chosen(answer, choice)
  "chosen" if answer.chosen_choice_ids.include?(choice.id) 
end

def class_valid(choice)
  "valid" if choice.valid_answer == true
end

def link_to_next(question_id, qcm_id, question_ids)
  next_id = question_ids.reject{ |id| id <= question_id }.first

  if not next_id.blank?
    link_to "Question suivante", new_qcm_question_answer_path(qcm_id, next_id)
  else
    link_to "Terminer", qcm_path(qcm_id)
  end
end

end
