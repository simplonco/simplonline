class AddValidToChoice < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :content
      t.belongs_to :question
      t.boolean :valid_answer
    end

    remove_column :questions, :choix1, :string
    remove_column :questions, :valid_answers, :string
    remove_column :questions, :choix2, :string
    remove_column :questions, :choix3, :string
    remove_column :questions, :choix4, :string
    remove_column :questions, :choix5, :string
    remove_column :questions, :choix6, :string
    remove_column :questions, :choix7, :string
    remove_column :questions, :choix8, :string
    remove_column :questions, :choix9, :string
  end
end
