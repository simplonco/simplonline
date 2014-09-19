class LexiquesController < ApplicationController

  def index
    @lexiques = Lexique.all
  end

  def new
  end

  def create
    lexique = Lexique.new(lexique_attributes)
    lexique.save!
    redirect_to action: :index
  end

  def edit
    @lexique = Lexique.find(params[:id])
    @available_authors = User.all
  end

  def update
    lexique = Lexique.find(params[:id])
    lexique.update_attributes(lexique_attributes)
    lexique.save!
    redirect_to action: :index
  end

  def show
    @lexique = Lexique.find(params[:id])
  end

  private

  def lexique_attributes
    params.require(:lexique).permit(:keyword, :description, :url)
  end
end
