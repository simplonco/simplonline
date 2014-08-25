class Question < ActiveRecord::Base
  belongs_to :qcm
  has_many :choices
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates_presence_of :qcm

  def valid_answers
    choices.where(valid_answer: true).count
  end

  def single_answer?
    valid_answers == 1
  end

end
