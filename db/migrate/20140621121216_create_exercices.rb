class CreateExercices < ActiveRecord::Migration
  def change
    create_table :exercices do |t|
      t.text :consigne
      t.text :input
      t.text :expected_output

      t.timestamps
    end
  end
end
