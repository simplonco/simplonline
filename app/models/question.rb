class Question < ActiveRecord::Base
  belongs_to :qcm
  has_many :choices
  has_many :answers
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates_presence_of :qcm

  def valid_answers
    choices.where(valid_answer: true)
  end

  def single_answer?
    valid_answers.count == 1
  end

end
