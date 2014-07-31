class ExercicesController < ApplicationController
  def index
    @exercices = Exercice.all
    @essais = utilisateur_actuel.essais
  end
  def new
    @exercice = Exercice.new
  end

  def create
    @exercice = Exercice.create(exercice_params)
    redirect_to exercice_path @exercice
  end

  def show
    @exercice = Exercice.find(params[:id])
    @essais = Essai.where(exercice_id: @exercice.id, utilisateur_id: utilisateur_actuel)
  end

  def edit
  end

  def update
  end

  private
  def exercice_params
    params.require(:exercice).permit(:consigne, :validateur, :format_reponse, :format_echantillon, :echantillon, :reponse)
  end
end
