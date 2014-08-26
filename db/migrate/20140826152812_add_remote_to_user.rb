class AddRemoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :remote, :boolean, default: true
  end
end
