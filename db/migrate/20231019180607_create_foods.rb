class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string "food_name"
      t.string "food_additions"
      t.string "food_modifiables"
      t.float "inital_cost"
      t.timestamps
    end
  end
end
