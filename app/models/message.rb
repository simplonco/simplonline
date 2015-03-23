class Message < ActiveRecord::Base
  belongs_to :user

  belongs_to :parent, class_name: 'Message'
  has_many :responses, -> { order 'created_at' }, class_name: 'Message', foreign_key: 'parent_id'

  NORMAL = :normal

  validates_presence_of :user, :status, :title

  scope :recent, -> { order('updated_at DESC') }

  def user_name
    user.name
  end

  def self.create_for(user, params)
    message = Message.new(params)
    message.user = user
    message.title = "RE: #{message.parent_id}"
    message.save!
  end

  def self.search(query)
    if query
      pg_query = query.split(' ').join(' & ')
      where("to_tsvector(title || ' ' || content) @@ to_tsquery('#{pg_query}')")
    else
      @messages
    end
  end

  def users_to_notify
    if parent
      [parent.user].concat(parent.users_to_notify).uniq
    else
      []
    end 
  end

end
