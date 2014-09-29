class AddAuthorsToLesson < ActiveRecord::Migration
  def change
    create_table :lesson_authors do |la|
      la.belongs_to :user
      la.belongs_to :lesson
    end
  end
end
