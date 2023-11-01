class DeleteColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :dinnerMenu
    remove_column :foods, :breakfastOrDinner
  end
end
