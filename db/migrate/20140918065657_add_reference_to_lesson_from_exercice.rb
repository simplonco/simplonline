class AddReferenceToLessonFromExercice < ActiveRecord::Migration
  def change
    add_reference :exercices, :lesson, index: true
  end
end
