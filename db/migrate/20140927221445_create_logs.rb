class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :trace, nil: false
      t.timestamps
    end
  end
end
