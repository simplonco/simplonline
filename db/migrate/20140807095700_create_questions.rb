class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.belongs_to :qcm
      t.string :choix1
      t.string :choix2
      t.string :choix3
      t.string :choix4
      t.string :choix5
      t.string :choix6
      t.string :choix7
      t.string :choix8
      t.string :choix9
      t.string :valid_answers
      t.timestamps
    end
  end
end
