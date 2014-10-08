class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter

  validates_presence_of :user, :chapter, :content

end
