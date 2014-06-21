class CreateEssais < ActiveRecord::Migration
  def change
    create_table :essais do |t|
      t.string :fichier
      t.boolean :status
      t.belongs_to :exercice

      t.timestamps
    end
  end
end
