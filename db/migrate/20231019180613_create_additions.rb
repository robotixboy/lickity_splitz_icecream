class CreateAdditions < ActiveRecord::Migration[7.0]
  def change
    create_table :additions do |t|
      t.string "addition_name"
      t.float "cost"
      t.timestamps
    end
  end
end
