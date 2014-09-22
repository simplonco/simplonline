class Chapter < ActiveRecord::Base
  belongs_to :lesson

  validates_presence_of :lesson, :title, :authors

  def insert_definitions
    Definition.all.each do |d|
      self.content = self.content.gsub(/\b#{d.keyword.to_sym}\b/i){ |s| "<a href='/definitions/#{d.id}' class='definition'>#{s}</a>"}
    end
    self.save!
  end
end
