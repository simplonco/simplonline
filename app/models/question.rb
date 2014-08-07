class Question < ActiveRecord::Base
  belongs_to :qcm

  def single_answer?
    valid_answers.split(',').count == 1
  end

end
