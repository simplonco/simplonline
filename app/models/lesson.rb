class Lesson < ActiveRecord::Base
  has_many :chapters
  has_many :qcms

  validates_presence_of :title

  scope :last_lessons, -> { all }
end
