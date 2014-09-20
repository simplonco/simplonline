class ChangeLexiqueToDefinition < ActiveRecord::Migration
  def change
    rename_table :lexiques, :definitions
  end
end
