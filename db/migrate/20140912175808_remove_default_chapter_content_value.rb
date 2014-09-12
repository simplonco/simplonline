class RemoveDefaultChapterContentValue < ActiveRecord::Migration
  def change
    change_column :chapters, :content, :text,  default: ''
  end
end
