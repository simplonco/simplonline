class Qcm < ActiveRecord::Base
  has_many :questions
  belongs_to :lesson

  validates_presence_of :lesson, :authors
  accepts_nested_attributes_for :questions, allow_destroy: true
end
