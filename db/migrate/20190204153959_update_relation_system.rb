class UpdateRelationSystem < ActiveRecord::Migration[5.2]
  def change
    drop_table :black_lists

    drop_table :relationships

    create_table :relations do |t|
      t.integer :related_id
    
      t.integer :relating_id

      t.integer :state, default: 0
    end

    add_index :relations, :related_id
    add_index :relations, :relating_id
    add_index :relations, [:related_id, :relating_id], unique: true
  end
end
