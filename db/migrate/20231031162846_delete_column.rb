class DeleteColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :dinnerMenu
  end
end
