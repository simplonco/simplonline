class CommentsController < ApplicationController
  skip_filter :remote_cant_access

  def create
    message = Message.find(params[:message_id])
    comment = message.comments.new(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to message_path(message)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
