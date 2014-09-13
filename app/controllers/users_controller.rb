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
    @last_lessons = Lesson.last_lessons
    @user = current_user
    @qcms = Qcm.last(5)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
