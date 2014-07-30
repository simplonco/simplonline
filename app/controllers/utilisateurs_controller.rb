class UtilisateursController < ApplicationController
  def edit
    @utilisateur = utilisateur_actuel
  end

  def update
    @utilisateur = utilisateur_actuel
    if @utilisateur.update utilisateur_params
      redirect_to root_url 
    else
      render 'edit', notice: "#{utilisateur_params} n'est pas disponible"
    end
  end

  private
  def utilisateur_params
    params.require(:utilisateur).permit(:nom)
  end
end
