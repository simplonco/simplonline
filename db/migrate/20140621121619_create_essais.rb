class CreateEssais < ActiveRecord::Migration
  def change
    create_table :essais do |t|
      t.text :content
      t.boolean :status
      t.belongs_to :exercice

      t.timestamps
    end
  end
end
