class AddFieldsToEssais < ActiveRecord::Migration
  def change
    add_column :essais, :reponse_char, :text
    add_column :essais, :fichier_tests, :string
  end
end
