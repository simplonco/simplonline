class RemoveAuthorsColFromQcms < ActiveRecord::Migration
  def change
    remove_column :qcms, :authors
  end
end
