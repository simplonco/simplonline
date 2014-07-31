class AddFormatEchantillonToExercices < ActiveRecord::Migration
  def change
    add_column :exercices, :format_echantillon, :string
  end
end
