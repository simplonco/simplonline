class CreateComments < ActiveRecord::Migration
  class Message < ActiveRecord::Base
    NORMAL = :normal
  end

  def change
    create_table :comments do |t|
      t.text :content, nil: false
      t.string :status, nil: false, default: Message::NORMAL
      t.belongs_to :user
      t.belongs_to :message

      t.timestamps

    end
  end
end
