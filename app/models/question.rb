class Question < ActiveRecord::Base
  belongs_to :qcm
  has_many :choices
  accepts_nested_attributes_for :choices, allow_destroy: true

  def single_answer?
    valid_answers.split(',').count == 1
  end

end
