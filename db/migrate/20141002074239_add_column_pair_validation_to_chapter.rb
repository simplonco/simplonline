class AddColumnPairValidationToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :ask_pair_validation, :boolean, nil: false, fdefault: false
  end
end
