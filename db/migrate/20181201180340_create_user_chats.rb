class CreateUserChats < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chats do |t|
      t.integer :user_id
      t.integer :chat_id
      t.timestamps
    end
    add_index :user_chats, :user_id
    add_index :user_chats, :chat_id
    add_index :user_chats, [:user_id, :chat_id], unique: true
  end
end
