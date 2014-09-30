class AddOrderFieldToChapterQcmQndExercice < ActiveRecord::Migration
  def change
    add_column :chapters, :number, :int, nil:false, default: 0
    add_column :qcms, :number, :int, nil:false, default: 0
    add_column :exercices, :number, :int, nil:false, default: 0
  end
end
