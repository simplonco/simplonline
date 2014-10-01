class MessagesController < ApplicationController

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

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

end
