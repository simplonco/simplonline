class CreateQcms < ActiveRecord::Migration
  def change
    create_table :qcms do |t|
      t.string :title
      t.text :desc
      t.timestamps
    end
  end
end
