class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string "username"
      t.string "password"
      t.string "phone_number"
      t.integer "authorization_key"
      t.timestamps
    end
  end
end
