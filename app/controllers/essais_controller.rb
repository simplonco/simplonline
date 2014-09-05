class EssaisController < ApplicationController

  def new
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.new
  end

  def show
    @essai = Essai.find(params[:id])
    #TODO
    #@afficher_essai = File.open(@essai.fichier) if @essai.exercice.format_reponse == 3 || 4 || 5
  end

  def create
    @exercice = Exercice.find(params[:exercice_id])
    @essai = @exercice.essais.new(essai_params)
    @essai.file_writer
    @essai.user_id = current_user.id
    @essai.save
    Verificateur.perform_async(@essai)
    redirect_to exercice_path(@essai.exercice.id)
  end

  def update
  end

  def accueil
  end

private
  def essai_params
    params.require(:essai).permit(:fichier, :exercice_id, :user_id, :validateur, :fichier_tests, :reponse_char)
  end

end
