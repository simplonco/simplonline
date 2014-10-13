class ValidationALaLargeColumn < ActiveRecord::Migration
  def up
    add_belongs_to :submissions, :first_validation_user, class: 'User'
    add_column :submissions, :first_validation_comment, :text
    add_column :submissions, :first_validation_status, :boolean, default: false

    add_belongs_to :submissions, :second_validation_user, class: 'User'
    add_column :submissions, :second_validation_comment, :text
    add_column :submissions, :second_validation_status, :boolean, default: false
  end

  def down
    remove_column :submissions, :first_validation_user_id
    remove_column :submissions, :first_validation_comment
    remove_column :submissions, :first_validation_status

    remove_column :submissions, :second_validation_user_id
    remove_column :submissions, :second_validation_comment
    remove_column :submissions, :second_validation_status
  end
end
