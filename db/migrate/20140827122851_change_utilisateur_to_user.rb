class ChangeUtilisateurToUser < ActiveRecord::Migration
  def change
    rename_column(:essais, :utilisateur_id, :user_id)
    rename_index(:essais, :index_essais_on_utilisateur_id, :index_essais_on_user_id)
  end
end
