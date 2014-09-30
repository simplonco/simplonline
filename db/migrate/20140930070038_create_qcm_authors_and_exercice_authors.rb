class CreateQcmAuthorsAndExerciceAuthors < ActiveRecord::Migration
  def change
    create_table :qcm_authors do |t|
      t.belongs_to :user
      t.belongs_to :qcm
    end

    create_table :exercice_authors do |t|
      t.belongs_to :user
      t.belongs_to :exercice
    end
  end
end
