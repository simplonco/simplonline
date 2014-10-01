class Message < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  NORMAL = :normal

  validates_presence_of :user, :status

  scope :recent, ->(limit=10) { order('updated_at DESC').limit(limit) }

  def user_name
    user.name
  end
end
