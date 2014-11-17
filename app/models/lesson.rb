class Lesson < ActiveRecord::Base
  has_many :chapters
  has_many :qcms
  has_many :exercices

  validates_presence_of :title

  default_scope -> { order('created_at DESC') }
  scope :last_lessons, -> { where(online: true) }
  scope :online, -> { where(online: true) }

  scope :edito_chapters, -> { where(category: 'edito') }

  I18n.t(:categories).each do |cat|
    define_method("#{cat}_chapters") do
      chapters.where(category: cat)
    end
  end

  def offline?
    ! online
  end
end
