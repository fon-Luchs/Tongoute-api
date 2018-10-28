class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.string :value
      t.integer :user_id

      t.timestamps
    end
  end
end
