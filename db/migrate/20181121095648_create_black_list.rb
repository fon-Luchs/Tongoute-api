class CreateBlackList < ActiveRecord::Migration[5.2]
  def change
    create_table :black_lists do |t|
      t.integer :blocker_id
      t.integer :blocked_id

      t.timestamps null: false
    end
    add_index :black_lists, :blocker_id
    add_index :black_lists, :blocked_id
    add_index :black_lists, [:blocker_id, :blocked_id], unique: true
  end
end
