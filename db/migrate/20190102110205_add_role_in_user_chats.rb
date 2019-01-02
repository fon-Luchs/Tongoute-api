class AddRoleInUserChats < ActiveRecord::Migration[5.2]
  def change
    add_column :user_chats, :role, :integer, default: 0
  end
end
