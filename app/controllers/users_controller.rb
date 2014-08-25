class UsersController < ApplicationController
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
    @user = User.find(params[:id])
    @qcms = Qcm.last(5)
  end

  private

  def user_params
    params.require(:user).permit(:nom)
  end
end
