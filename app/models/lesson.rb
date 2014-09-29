class Lesson < ActiveRecord::Base
  has_many :chapters
  has_many :qcms
  has_many :exercices

  has_many :lesson_authors
  has_many :authors, through: :lesson_authors, source: :user

  validates_presence_of :title, :authors

  scope :last_lessons, -> { where(online: true) }
  scope :online, -> { where(online: true) }

  def offline?
    ! online
  end
end
