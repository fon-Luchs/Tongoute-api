class DropBlockUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :block_users
  end
end
