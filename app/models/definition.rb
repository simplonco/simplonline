class Definition < ActiveRecord::Base
  validates_presence_of :keyword, :description
  validates_uniqueness_of :keyword

  scope :last_updated, -> { order('updated_at DESC') }

  def add_links_in_chapters
    Chapter.all.each do |chap|
      chap.content = chap.content.gsub(/[\*]*#{self.keyword.to_sym}[\*]*/i) { |s| "[#{s}](/definitions/#{self.id})" }
      chap.save!
    end
  end

  def delete_links_in_chapters
    Chapter.all.each do |chap|
      chap.content = chap.content.gsub(/\[[\*]*#{self.keyword.to_sym}[\*]*]\(\/definitions\/#{self.id}\)/i) do |s|
        s.match(/[\*]*#{self.keyword}[\*]*/i)
      end
      chap.save!
    end
  end
end
