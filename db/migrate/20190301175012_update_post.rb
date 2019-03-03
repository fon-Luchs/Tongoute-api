class UpdatePost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :user_id, :integer
    remove_column :posts, :destination_id, :integer
    remove_column :posts, :title, :string

    add_column :posts, :wall_id, :integer
    add_column :posts, :postable_id, :integer
    add_column :posts, :postable_type, :string
    add_column :posts, :pinned, :boolean

    add_index :posts, :wall_id
    add_index :posts, :postable_id
    add_index :posts, :postable_type
  end
end
