class ExercicesController < ApplicationController
  def index
    @exercices = Exercice.all
    @essais = current_user.essais
  end
  def new
    @exercice = Exercice.new
  end

  def create
    @exercice = Exercice.create(exercice_params)
    ExerciceWorker.perform_async(exercice_params.merge(id: @exercice.id))
    redirect_to exercice_path @exercice
  end

  def show
    @exercice = Exercice.find(params[:id])
    @essais = Essai.where(exercice_id: @exercice.id, user_id: current_user)
  end

  def edit
  end

  def update
    @exercice = Exercice.find(params[:id])
  end

  private
  def exercice_params
    params.require(:exercice).permit(:consigne, :validateur, :format_reponse, :format_echantillon, :echantillon, :reponse)
  end
end
