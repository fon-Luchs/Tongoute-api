class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :messageable_id
      t.string  :messageable_type
      t.string  :text

      t.timestamps
    end
    add_index :messages, :messageable_id
    add_index :messages, :messageable_type
  end
end
