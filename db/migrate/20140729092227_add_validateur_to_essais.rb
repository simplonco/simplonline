class AddValidateurToEssais < ActiveRecord::Migration
  def change
    add_column :essais, :validateur, :text
    add_column :exercices, :format_reponse, :integer
    rename_column :exercices, :expected_output, :reponse
    rename_column :exercices, :input, :echantillon
  end
end
