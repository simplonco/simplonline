class Definition < ActiveRecord::Base
  validates_presence_of :keyword, :description

  scope :last_updated, -> { order('updated_at DESC') }
end
