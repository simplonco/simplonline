class Chapter < ActiveRecord::Base
  belongs_to :lesson

  validates_presence_of :lesson, :title, :authors

  def insert_definitions!
    Definition.all.each do |definition|
      self.content = self.content.gsub(/[\*_]*#{definition.keyword.to_sym}[\*_]*/i){ |s| "[#{s}](/definitions/#{definition.id})"}
    end
  end
end
