class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter

  belongs_to :first_validation_user, class_name: 'User'
  belongs_to :second_validation_user, class_name: 'User'

  validates_presence_of :user, :chapter, :content

  def user_name
    user.name
  end

  def add_validation_from(user, status, comment)
    self.first_validation_user = user
    self.first_validation_status = status
    self.first_validation_comment = comment
  end
end
