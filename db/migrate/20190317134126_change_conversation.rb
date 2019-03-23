class ChangeConversation < ActiveRecord::Migration[5.2]
  def change
    remove_index :conversations, column: [:recipient_id, :recipient_type, :sender_id, :sender_type]
    rename_column :conversations, :sender_id, :senderable_id
    rename_column :conversations, :recipient_id, :recipientable_id
    rename_column :conversations, :sender_type, :senderable_type
    rename_column :conversations, :recipient_type, :recipientable_type
  end
end
