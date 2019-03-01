class CreateWalls < ActiveRecord::Migration[5.2]
  def change
    create_table :walls do |t|
      t.string :wallable_type
      t.integer :wallable_id

      t.timestamps
    end
    add_index :walls, :wallable_id
    add_index :walls, :wallable_type
  end
end
