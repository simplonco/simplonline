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

  def find_first_unanswered_question(question)
    qcm_questions = Question.all.select{ |q| q.qcm_id = question.qcm_id}

    questions_without_answers = qcm_questions.select { |q| q if q.answers == []}

    questions_without_answers.first
  end

  def next
    qcm.questions.where('position > ?', self.position).order(:position).first
  end

  def previous
    qcm.questions.where('position < ?', self.position).order("position desc").first
  end

  def answer_allowed?(user)
    previous = self.previous
    if previous.present?
      ans = Answer.find_by(user:user, question:previous)
      ans && ans.is_valid?
    else
      true
    end
  end
end
