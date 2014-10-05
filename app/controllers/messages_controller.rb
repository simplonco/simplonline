class MessagesController < ApplicationController
  skip_filter :remote_cant_access

  def new
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    message.save!
    redirect_to messages_path
  end

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    message = Message.find(params[:id])
    message.update_attributes(message_params)
    message.save!
    redirect_to messages_path
  end

  def destroy
    message = Message.find(params[:id])
    message.delete
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

end
