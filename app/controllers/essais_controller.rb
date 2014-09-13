class EssaisController < ApplicationController
before_action :exercice, only: [:new, :create, :show]
  
  def new
    @essai = @exercice.essais.new
  end

  def show
    @essai = Essai.find(params[:id])
    #TODO @afficher_essai = File.open(@essai.fichier)
  end

  def create
    @essai = @exercice.essais.new(essai_params)
    @essai.user_id = current_user.id
    case @essai.exercice.format_reponse 
    when 3 || 4 || 5
      @essai.file_writer
      @essai.save
      Verificateur.perform_async(@essai)
      last_essai = Essai.where(user_id: @essai.user_id, exercice_id: @essai.exercice_id).order("id DESC").offset(1).first
      last_essai.delete
      last_essai.save
    when 1 || 2
      @essai.status = true if @exercice.reponse == @essai.reponse_char
      @essai.save
    end
    redirect_to exercice_path(@essai.exercice.id)
  end

private
  def exercice
    @exercice = Exercice.find(params[:exercice_id])
  end

  def essai_params
    params.require(:essai).permit(:fichier, :exercice_id, :user_id, :validateur, :fichier_tests, :reponse_char)
  end

end
