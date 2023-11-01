# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_01_142913) do
  create_table "additions", force: :cascade do |t|
    t.string "addition_name"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "phone_number"
    t.integer "authorization_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "food_name"
    t.string "food_additions"
    t.string "food_modifiables"
    t.float "inital_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "breakfastOrDinner"
    t.boolean "isBreakfast"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "order_id"
    t.text "list_food_id"
    t.text "list_food_notes"
    t.float "total_cost"
    t.integer "completed_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temp_orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "food_id"
    t.text "food_modifications"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
