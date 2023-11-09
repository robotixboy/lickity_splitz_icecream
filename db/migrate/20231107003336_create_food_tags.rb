class CreateFoodTags < ActiveRecord::Migration[7.0]
  def change
    create_table :food_tags do |t|
      t.string "food_Tag_Name"
      t.timestamps
    end
  end
end
