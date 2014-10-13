class AddIndex < ActiveRecord::Migration
  def change
    add_index :definitions, :keyword
  end
end
