class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates_presence_of :question, :user

  def is_valid?
    valid_ids = question.valid_answers.map {|answer| answer.id}
    chosen_choice_ids == valid_ids
  end

  #TODO à stocker comme un array dans pg
  def chosen_choice_ids
    chosen_choices.split(",").map{|id| id.to_i}
  end
end
