class AddEmailAndPasswordToUser < ActiveRecord::Migration
  def up
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    remove_column :users, :uid
    remove_column :users, :provider
  end

  def down
    remove_column :users, :email
    remove_column :users, :password_digest
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
