class CreateAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :animals do |t|
      t.string :image, null: false
      t.string :species, null: false
      t.string :sex, null: false
      t.string :color
      t.text :body
      t.integer :price

      t.timestamps
    end
  end
end
