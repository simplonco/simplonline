class Chapter < ActiveRecord::Base
  belongs_to :lesson
  has_many :submissions

  has_many :chapter_authors
  has_many :authors, through: :chapter_authors, source: :user

  validates_presence_of :lesson, :title, :authors, :number

  Tags = %w{ code_review book_review kata tools framework }

  scope :about, ->(tag) { where("ARRAY[?]::varchar[] && tags", tag) }

  default_scope { order(:number) }

  def insert_definitions!
    Definition.all.each do |definition|
      self.content = self.content.gsub(/[\*]*#{definition.keyword.to_sym}[\*]*/i) { |s| "[#{s}](/definitions/#{definition.id})" }
    end
  end

  def tags=(tags)
    tags.reject!(&:blank?)
    write_attribute(:tags, tags)
  end

  def next
    self.lesson.chapters.where('number > ?', self.number).order(:number).first
  end

  def user_submission(user)
    self.submissions.find_by(user: user)
  end
end
