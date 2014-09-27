class ChangeRemoteToUserType < ActiveRecord::Migration
  class User < ActiveRecord::Base
    LOCAL = :local
    REMOTE = :remote
  end

  def change
    add_column :users, :student_type, :string, nil: false, default: User::REMOTE
    User.all.each do |user|
      unless user.remote?
        user.student_type = User::LOCAL
        user.save!
      end
    end

    remove_column :users, :remote
  end
end
