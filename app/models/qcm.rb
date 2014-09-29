class Qcm < ActiveRecord::Base
  has_many :questions
  belongs_to :lesson

  has_many :qcm_authors
  has_many :authors, through: :qcm_authors, source: :user

  validates_presence_of :lesson, :authors

  accepts_nested_attributes_for :questions, allow_destroy: true
end
