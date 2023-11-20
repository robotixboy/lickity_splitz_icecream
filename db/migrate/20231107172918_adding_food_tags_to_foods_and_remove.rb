class AddingFoodTagsToFoodsAndRemove < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :tag, :string
  end
end
