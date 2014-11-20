class Chapter < ActiveRecord::Base
  belongs_to :lesson
  has_many :submissions, dependent: :destroy

  has_many :chapter_authors
  has_many :authors, through: :chapter_authors, source: :user

  validates_presence_of :lesson, :title, :authors, :number

  scope :about, ->(tag) { where("ARRAY[?]::varchar[] && tags", tag) }

  default_scope { order(:number) }

  def tags=(tags)
    tags.reject!(&:blank?)
    write_attribute(:tags, tags)
  end

  def ask_pair_validation=(value)
    unless value
      submissions.delete_all
    end
    write_attribute(:ask_pair_validation, value)
  end

  def content=(chapter_content)
    chapter_content = chapter_content.split("\n").map!(&:strip).join("\n")
    write_attribute(:content, chapter_content)
  end

  def next
    next_prev('number > ?').first
  end

  def prev
    next_prev('number < ?').last
  end

  def user_submission(user)
    self.submissions.find_by(user: user)
  end

  def user_submission_validated?(user)
    self.submissions.where(user: user).where(first_validation_status: true, second_validation_status: true).exists?
  end

  def submissions_to_validate(user)
    subs = []
    subs.concat(submissions.where(first_validation_status: false))
    subs.concat(submissions.where(second_validation_status: false))
    subs = subs.select{|s| s.first_validation_user != user }
    subs.uniq
  end

  def validated_submissions(user)
    subs = []
    subs.concat(submissions.where(first_validation_status: true))
    subs = subs.select{|s| s.first_validation_user != user }
    subs.concat(submissions.where(second_validation_status: true))
    subs = subs.select{|s| s.second_validation_user != user }
    subs.uniq
  end

  private

  def next_prev(direction)
    self.lesson.chapters.where(direction, self.number).order(:number)
  end

end
