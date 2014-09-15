class ResetPasswordsController < ApplicationController
  skip_filter :authenticate_user

  def new
  end

  def create
    redirect_to welcome_path
  end

  def edit
    @user = User.first
  end

  def update
    redirect_to root_path
  end

end
