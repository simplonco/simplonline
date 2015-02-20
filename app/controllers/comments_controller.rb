class CommentsController < ApplicationController
  skip_filter :remote_cant_access

  def create
    parent = Message.find(params[:message_id])
    message = parent.responses.new(message_params)
    message.user = current_user
    message.title = "RE: #{parent.title}"
    message.save!

    users = message.users_to_notify
    users.each do |user|
      UserMailer.message_post_notification(user, message).deliver
    end

    redirect_to message_path(parent, anchor: message)
  end

  def index
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
