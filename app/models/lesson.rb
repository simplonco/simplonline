class Lesson < ActiveRecord::Base

  validates_presence_of :title

  scope :last_lessons, -> { all }
end
