class Definition < ActiveRecord::Base
  validates_presence_of :keyword, :description
  validates_uniqueness_of :keyword
  
  scope :last_updated, -> { order('updated_at DESC') }

  def links_in_chapters
    Chapter.all.each do |chap|
      chap.content = chap.content.gsub(self.keyword, "<a href='/definitions/#{self.id}' class='definition'>#{self.keyword}</a>")
      chap.save!
    end
  end
end
