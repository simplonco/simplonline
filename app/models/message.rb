class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user

  scope :recent, ->(limit=10) { order('updated_at DESC').limit(limit) }

  def user_name
    user.name
  end
end
