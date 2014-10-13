class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :chapter
      t.belongs_to :user
      t.text :content, nil: false

      t.timestamps
    end

    create_table :submission_results do |s|
      s.belongs_to :submission
      s.belongs_to :user
      s.text :comment, nil: false
      s.boolean :good, nil: false, default: false

      s.timestamps
    end
  end
end
