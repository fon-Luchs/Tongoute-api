class CreateBlockUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :block_users do |t|
      t.references :user, foreign_key: true
      t.integer :blocked_id

      t.timestamps
    end
  end
end
