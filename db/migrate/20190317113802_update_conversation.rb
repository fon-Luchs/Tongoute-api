class UpdateConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :sender_type, :string
    add_column :conversations, :recipient_type, :string
    remove_index :conversations, column: [:sender_id, :recipient_id]
    add_index :conversations, [:recipient_id, :recipient_type, :sender_id, :sender_type],
               unique: true, name: 'index_recipient_type_id_and_sender_type_id'
  end
end
