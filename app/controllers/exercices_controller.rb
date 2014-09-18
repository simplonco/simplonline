class ExercicesController < ApplicationController

  def index
    @exercices = Exercice.all
    @essais = current_user.essais
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
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
    @exercice = Exercice.find(params[:id])
  end

  def update
    @exercice = Exercice.find(params[:id])
    @exercice.update(exercice_params.merge(id: @exercice.id))
    ExerciceWorker.perform_async(exercice_params.merge(id: @exercice.id))
    redirect_to exercice_path @exercice
  end

  private
  def exercice_params
    params.require(:exercice).permit(:titre, :consigne, :validateur, :format_reponse, :format_echantillon, :echantillon, :reponse)
  end
end
