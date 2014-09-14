class AddAuthorsToChapterAndQcm < ActiveRecord::Migration
  def change
    add_column :chapters, :authors, :string, array: true, default: []
    add_column :qcms, :authors, :string, array: true, default: []
  end
end
