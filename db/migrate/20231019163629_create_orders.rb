class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id, foreign_key: true
      t.integer :order_id
      t.text :list_food_id
      t.text :list_food_notes
      t.float :total_cost
      t.integer :completed_order

      t.timestamps
    end
  end
end
