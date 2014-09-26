class Chapter < ActiveRecord::Base
  belongs_to :lesson

  has_many :chapter_authors
  has_many :authors, through: :chapter_authors, source: :user

  validates_presence_of :lesson, :title, :authors

  def insert_definitions!
    Definition.all.each do |definition|
      self.content = self.content.gsub(/[\*]*#{definition.keyword.to_sym}[\*]*/i) { |s| "[#{s}](/definitions/#{definition.id})" }
    end
  end
end
