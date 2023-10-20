class CreateTempOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :temp_orders do |t|
      t.integer :customer_id, foreign_key: true
      t.integer :food_id, foreign_key: true
      t.text :food_modifications
      t.float :total_cost
      t.timestamps
    end
  end
end
