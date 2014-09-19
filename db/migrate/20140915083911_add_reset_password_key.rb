class AddResetPasswordKey < ActiveRecord::Migration
  def change
    add_column :users, :reset_password_key, :string
  end
end
