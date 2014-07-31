class AddAdminToUtilisateur < ActiveRecord::Migration
  def change
    add_column :utilisateurs, :admin, :boolean, default: false
    add_reference :essais, :utilisateur, index: true
  end
end
