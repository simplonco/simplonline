class EssaisController < ApplicationController

  def new
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.new
  end

  def show
    @essai = Essai.find(params[:id])
  end

  def create
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.new(essai_params)
    @essai.utilisateur_id = utilisateur_actuel.id
    @essai.save
    Verificateur.perform_async(@essai.id)
    redirect_to exercice_path(@essai.exercice.id)
  end

  def update
  end
  
  def accueil
  end

private
  def essai_params
    params.require(:essai).permit(:fichier, :exercice_id, :utilisateur_id, :validateur, :fichier_tests, :reponse_char)
  end

end
