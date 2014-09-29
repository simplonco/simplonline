class CreateTableChapterAuthors < ActiveRecord::Migration
  def change
    create_table :table_chapter_authors do |t|
      t.belongs_to :user
      t.belongs_to :chapter
    end
  end
end
