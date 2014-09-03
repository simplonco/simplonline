class ChangeUtilisateurToUser < ActiveRecord::Migration
  def change
    rename_column(:essais, :utilisateur_id, :user_id)
  end
end
