class RenameTableTableChapterAuthors < ActiveRecord::Migration
  def change
    rename_table :table_chapter_authors, :chapter_authors
  end
end
