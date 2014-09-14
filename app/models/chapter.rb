class Chapter < ActiveRecord::Base
  belongs_to :lesson

  validates_presence_of :lesson, :title, :authors
end
