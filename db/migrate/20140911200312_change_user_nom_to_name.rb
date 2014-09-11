class ChangeUserNomToName < ActiveRecord::Migration
  def change
    rename_column :users, :nom, :name
  end
end
