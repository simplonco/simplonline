class RenameTableTableChapterAuthors < ActiveRecord::Migration
  def change
    drop_table :chapter_authors
    rename_table :table_chapter_authors, :chapter_authors
  end
end
