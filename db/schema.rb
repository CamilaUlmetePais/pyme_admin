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

ActiveRecord::Schema[7.0].define(version: 2023_06_29_224620) do
  create_table "inflow_items", force: :cascade do |t|
    t.float "quantity"
    t.integer "inflow_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inflow_id"], name: "index_inflow_items_on_inflow_id"
    t.index ["product_id"], name: "index_inflow_items_on_product_id"
  end

  create_table "inflows", force: :cascade do |t|
    t.float "total"
    t.integer "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.boolean "done"
    t.integer "notification_type"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outflow_items", force: :cascade do |t|
    t.float "quantity"
    t.integer "outflow_id", null: false
    t.integer "supply_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outflow_id"], name: "index_outflow_items_on_outflow_id"
    t.index ["supply_id"], name: "index_outflow_items_on_supply_id"
  end

  create_table "outflows", force: :cascade do |t|
    t.float "total"
    t.integer "payment_method"
    t.text "notes"
    t.float "paid"
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_outflows_on_supplier_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "unit"
    t.float "stock"
    t.integer "notification_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.float "account_balance"
    t.integer "notification_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "unit"
    t.float "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_product_links", force: :cascade do |t|
    t.integer "supply_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_supply_product_links_on_product_id"
    t.index ["supply_id"], name: "index_supply_product_links_on_supply_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "inflow_items", "inflows"
  add_foreign_key "inflow_items", "products"
  add_foreign_key "outflow_items", "outflows"
  add_foreign_key "outflow_items", "supplies"
  add_foreign_key "outflows", "suppliers"
  add_foreign_key "supply_product_links", "products"
  add_foreign_key "supply_product_links", "supplies"
end
