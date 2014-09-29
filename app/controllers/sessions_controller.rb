class SessionsController < ApplicationController
  skip_filter :authenticate_user, only: [:create]
  skip_filter :remote_can_access

  def create
    user = User.login(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connecté!"
    else
      flash[:error] = 'User or password invalid'
      redirect_to welcome_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Déconnecté!'
  end
end
