class ResetPasswordsController < ApplicationController
  skip_filter :authenticate_user
  skip_filter :remote_cant_access

  def new
  end

  def create
    User.reset_password(params[:email])
    redirect_to welcome_path
  end

  def edit
    @user = User.find_by(reset_password_key: params[:key])
    if @user.nil?
      flash[:error] = I18n.t('error.user_not_found')
      redirect_to welcome_path
    end
    @key = params[:key]
  end

  def update
    @user = User.find_by(reset_password_key: params[:key])
    if @user.nil?
      flash[:error] = I18n.t('error.user_not_found')
      redirect_to welcome_path
    else
      @user.update_password(params[:password], params[:password_confirmation])
      redirect_to root_path
    end
  end

end
