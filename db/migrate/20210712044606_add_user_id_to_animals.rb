class AddUserIdToAnimals < ActiveRecord::Migration[5.1]
  def change
    add_reference :animals, :user, foreign_key: true
  end
end
