class AuthorsLinkToUser < ActiveRecord::Migration
  def change
    remove_column :chapters, :authors
  end
end
