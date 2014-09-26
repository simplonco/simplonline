class Definition < ActiveRecord::Base
  validates_presence_of :keyword, :description
  validates_uniqueness_of :keyword

  scope :last_updated, -> { order('updated_at DESC') }

  def add_links_in_chapters
    Chapter.all.each do |chap|
      chap.content = chap.content.gsub(/\b#{self.keyword.to_sym}\b/i, "<a href='/definitions/#{self.id}' class='definition'>#{self.keyword}</a>")
      chap.save!
    end
  end

  def delete_links_in_chapters
    Chapter.all.each do |chap|
      chap.content = chap.content.gsub(/<a\s[^>]*>.*?#{self.keyword}.*?<\/a>/i, self.keyword)
      chap.save!
    end
  end
end
