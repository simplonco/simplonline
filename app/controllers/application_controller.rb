class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :utilisateur_actuel

  private
  def utilisateur_actuel
    @utilisateur_actuel ||= Utilisateur.find(session[:utilisateur_id]) if session[:utilisateur_id]
  end
end
