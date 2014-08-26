class CreateAnswer < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :chosen_choices
      t.belongs_to :question
      t.belongs_to :user
    end
    add_column :choices, :explanation, :text
  end
end
