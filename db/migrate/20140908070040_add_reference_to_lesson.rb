class AddReferenceToLesson < ActiveRecord::Migration
  def change
    add_reference :qcms, :lesson, index: true
  end
end
