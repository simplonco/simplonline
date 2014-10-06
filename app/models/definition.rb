class Definition < ActiveRecord::Base
  validates_presence_of :keyword, :description
  validates_uniqueness_of :keyword

  scope :last_updated, -> { order('updated_at DESC') }

  def add_links_in_chapters
  end

  def delete_links_in_chapters
  end
end
