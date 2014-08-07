class SessionsController < ApplicationController
  def create
    user = User.login(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Connecté!"
    else
      flash[:error] = 'User or password invalid'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Déconnecté!'
  end
end
