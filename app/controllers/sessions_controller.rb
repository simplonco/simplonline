class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    utilisateur = Utilisateur.find_by_provider_and_uid(auth[:provider], auth[:uid]) || Utilisateur.create_with_omniauth(auth)
    session[:utilisateur_id] = utilisateur.id
    redirect_to root_url, notice: "Connecté!"
  end

  def destroy
    session[:utilisateur_id] = nil
    redirect_to root_url, notice: 'Déconnecté!'
  end
end
