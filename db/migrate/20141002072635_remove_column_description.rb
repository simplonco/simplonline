class RemoveColumnDescription < ActiveRecord::Migration
  def up
    remove_column :lessons, :description
    drop_table :lesson_authors
  end

  def down
    add_column :lessons, :description, :text
    create_table :lesson_authors do |la|
      la.belongs_to :user
      la.belongs_to :lesson
    end
  end
end
