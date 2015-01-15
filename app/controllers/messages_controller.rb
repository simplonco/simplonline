class MessagesController < ApplicationController
  skip_filter :remote_cant_access
  before_filter :set_message, except: [:new, :create, :index]
  before_filter :can_access_message, only: [:edit, :update, :destroy]

  def new
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    message.save!
    redirect_to messages_path
  end

  def index
    @result_messages = Message.search(params[:query])
    @messages = Message.recent.page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    @message.update_attributes(message_params)
    @message.save!
    redirect_to messages_path
  end

  def destroy
    @message.delete
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def can_access_message
    redirect_to(root_url, status: 403) unless current_user == @message.user
  end

end
