class AddColumnForParentMessage < ActiveRecord::Migration
  class Message < ActiveRecord::Base
    belongs_to :parent, class_name: 'Message'
    has_many :comments
  end

  class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :message
  end

  def change
    add_belongs_to :messages, :parent, class: 'Message'

    Comment.all.each do |comment|
      new_message = Message.new
      new_message.parent = comment.message
      new_message.user = comment.user
      new_message.created_at = comment.created_at
      new_message.updated_at = comment.updated_at
      new_message.content = comment.content
      new_message.status = comment.status
      new_message.save!
    end
  end
end
