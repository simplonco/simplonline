class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates_presence_of :user, :status, :message

  def user_name
    user.name
  end
end
