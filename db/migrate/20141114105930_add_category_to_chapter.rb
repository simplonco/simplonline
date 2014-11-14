class AddCategoryToChapter < ActiveRecord::Migration
  def up
    add_column :chapters, :category, :string
  end

  def down
    remove_column :chapters, :category
  end
end
