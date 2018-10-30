class AddColumnsForUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :number,  :string
    add_column :users, :address, :string
    add_column :users, :date,    :date
    add_column :users, :about,   :text
  end
end
