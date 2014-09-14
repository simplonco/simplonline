class ChangeChosenChoiceTypeToArray < ActiveRecord::Migration
  def change
    remove_column :answers, :chosen_choices, :string
    add_column :answers, :chosen_choices, :integer, array: true
  end
end
