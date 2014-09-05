class Lesson < ActiveRecord::Base
  has_many :chapters

  validates_presence_of :title

  scope :last_lessons, -> { all }
end
