class AddAttributesToLessonAndCreateChapters < ActiveRecord::Migration
  def change
    add_column :lessons, :publish_at, :datetime

    create_table :chapters do |ch|
      ch.belongs_to :lesson
      ch.text :content, null: false, default: 'once uppon a time...'
      ch.string :title
      ch.timestamp
    end
  end
end
