class AddLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.timestamps
    end
  end
end
