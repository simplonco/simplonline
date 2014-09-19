class Lexique < ActiveRecord::Migration
  def change
    create_table :lexiques do |t|
      t.string :keyword
      t.text :description
      t.text :url
      # t.string :authors, array: true, default: []

      t.timestamps
    end
  end
end
