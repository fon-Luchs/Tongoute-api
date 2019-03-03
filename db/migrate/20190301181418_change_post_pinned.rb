class ChangePostPinned < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :pinned, :boolean, default: false
  end
end
