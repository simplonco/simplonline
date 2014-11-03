class Lesson < ActiveRecord::Base
  has_many :chapters
  has_many :qcms
  has_many :exercices

  validates_presence_of :title

  default_scope -> { order(:created_at) }
  scope :last_lessons, -> { where(online: true) }
  scope :online, -> { where(online: true) }

  def offline?
    ! online
  end
end
