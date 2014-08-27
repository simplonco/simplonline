class UsersController < ApplicationController
  before_filter :authenticate_user

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update user_params
      redirect_to root_url
    else
      render 'edit', notice: "#{user_params} n'est pas disponible"
    end
  end

  def show
    @user = current_user
    @qcms = Qcm.last(5)
  end

  private

  def user_params
    params.require(:user).permit(:nom)
  end
end
