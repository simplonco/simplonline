class EssaisController < ApplicationController
  def index
    @essais = Essai.all
    @exercices = Exercice.all
  end

  def new
    @essai = Essai.new
  end

  def show
    @essai = Essai.find(params[:id])

  end

  def create
    @essai = Essai.create(essai_params)
    Verificateur.perform_async(@essai.id)
    redirect_to root_path
  end

  def update
  end

private
  def essai_params
    params.require(:essai).permit(:fichier, :exercice_id)
  end

end
