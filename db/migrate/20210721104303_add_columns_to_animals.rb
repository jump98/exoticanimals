class AddColumnsToAnimals < ActiveRecord::Migration[5.1]
  def change
    add_column :animals, :image2, :string
    add_column :animals, :image3, :string
  end
end
