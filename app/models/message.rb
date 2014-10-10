class Message < ActiveRecord::Base
  belongs_to :user

  belongs_to :parent, class_name: 'Message'
  has_many :responses, -> { order 'created_at' }, class_name: 'Message', foreign_key: 'parent_id'

  NORMAL = :normal

  validates_presence_of :user, :status, :title

  scope :recent, ->(limit=10) { order('updated_at DESC').limit(limit) }

  def user_name
    user.name
  end

  def self.create_for(user, params)
    message = Message.new(params)
    message.user = user
    message.title = "RE: #{message.parent_id}"
    message.save!
  end

end
