class EssaisController < ApplicationController
  def index
    @essais = Essai.all
    @exercices = Exercice.all
  end

  def new
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.new
  end

  def show
    @essai = Essai.find(params[:id])
    @afficher_fichier = File.open "exercice/#{@essai.exercice.id}/user/essai/#{@essai.id}"
  end

  def create
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.create(essai_params)
    Verificateur.perform_async(@essai.id)
    redirect_to exercice_path(@essai.exercice.id)
  end

  def update
  end

private
  def essai_params
    params.require(:essai).permit(:fichier, :exercice_id, :validateur, :fichier_tests, :reponse_char)
  end

end
