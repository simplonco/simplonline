class ChangePublishdAtToPublicBool < ActiveRecord::Migration
  def change
    remove_column :lessons, :publish_at
    add_column :lessons, :online, :boolean, nil: false, default: false
  end
end
