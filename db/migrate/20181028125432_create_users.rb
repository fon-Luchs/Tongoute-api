class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :password_digest

      t.timestamps
    end
    add_index :users, [:first_name, :last_name]
  end
end
