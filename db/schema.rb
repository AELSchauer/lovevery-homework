# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_09_224215) do

  create_table "children", force: :cascade do |t|
    t.string "full_name", null: false
    t.date "birthdate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id", "full_name", "birthdate"], name: "index_children_on_user_id_and_full_name_and_birthdate", unique: true
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "order_id", null: false
    t.string "purchaser_name", null: false
    t.string "purchaser_email", null: false
    t.text "gift_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_gifts_on_child_id"
    t.index ["order_id"], name: "index_gifts_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "user_facing_id", null: false
    t.integer "product_id", null: false
    t.integer "child_id", null: false
    t.string "shipping_name", null: false
    t.string "address", null: false
    t.string "zipcode", null: false
    t.boolean "paid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_orders_on_child_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "price_cents", null: false
    t.integer "age_low_weeks", null: false
    t.integer "age_high_weeks", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_address"], name: "index_users_on_email_address"
  end

  add_foreign_key "children", "users"
  add_foreign_key "gifts", "children"
  add_foreign_key "gifts", "orders"
  add_foreign_key "orders", "children"
  add_foreign_key "orders", "products"
end
