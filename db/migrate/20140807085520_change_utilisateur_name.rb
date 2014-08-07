class ChangeUtilisateurName < ActiveRecord::Migration
  def change
    rename_table :utilisateurs, :users
  end
end
