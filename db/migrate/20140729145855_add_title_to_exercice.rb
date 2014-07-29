class AddTitleToExercice < ActiveRecord::Migration
  def change
    add_column :exercices, :titre, :string
  end
end
