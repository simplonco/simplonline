class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates_presence_of :question, :user

  def is_valid?
    chosen_choices == question.valid_answers.map {|answer| answer.id}
  end

end
