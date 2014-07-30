class CreateUtilisateurs < ActiveRecord::Migration
  def change
    create_table :utilisateurs do |t|
      t.string :uid
      t.string :nom
      t.string :provider

      t.timestamps
    end
  end
end
