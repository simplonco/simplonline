class AddTagsToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :tags, :string, array: true, default: []
  end
end
