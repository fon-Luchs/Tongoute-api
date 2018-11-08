class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.references :user, foreign_key: true
      t.integer :subscriber_id

      t.timestamps
    end
  end
end

