class TagsController < ApplicationController

  def show
    @tag = params[:id]
    @chapters = Chapter.about(@tag)
  end

end
