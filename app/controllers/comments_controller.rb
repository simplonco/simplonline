class CommentsController < ApplicationController
  skip_filter :remote_cant_access

  def create
    message = Message.find(params[:message_id])
    comment = message.comments.new(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to message_path(message)
  end

  def edit
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
  end

  def update
    message = Message.find(params[:message_id])
    comment = message.comments.find(params[:id])
    comment.update_attributes(comment_params)
    comment.save!
    redirect_to message_path(message)
  end

  def destroy
    message = Message.find(params[:message_id])
    comment = message.comments.find(params[:id])
    comment.delete
    redirect_to message_path(message)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
