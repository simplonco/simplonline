class CreateMessages < ActiveRecord::Migration
  class Message < ActiveRecord::Base
    NORMAL = :normal
  end

  def change
    create_table :messages do |t|
      t.string :title
      t.text :content, nil: false
      t.string :status, nil: false, default: Message::NORMAL
      t.belongs_to :user

      t.timestamps
    end
  end
end
