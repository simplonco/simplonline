class AddColumnTipsForQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :tips, :text
  end
end
