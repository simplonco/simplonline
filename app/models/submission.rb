class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter

  belongs_to :first_validation_user, class_name: 'User'
  belongs_to :second_validation_user, class_name: 'User'

  validates_presence_of :user, :chapter, :content


  def user_name
    user.name
  end

  def self.to_validate(user)
    result = []
    result = where(second_validation_user: nil)
    result = result.select {|e| e.first_validation_user != user}
    result
  end

  def add_validation_from(user, status, comment)
    self.first_validation_user = user
    self.first_validation_status = status
    self.first_validation_comment = comment
  end

  def missing_validations
    return 0 if first_validation_user && second_validation_user
    return 1 if first_validation_user
    2
  end
end
