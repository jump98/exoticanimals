class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
    add_column :users, :town, :string
    add_column :users, :address, :string
    add_column :users, :building, :string
    add_column :users, :LINE_id, :string
    add_column :users, :release, :boolean, default: false
  end
end
