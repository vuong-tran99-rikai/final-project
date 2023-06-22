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

ActiveRecord::Schema.define(version: 2023_06_18_041249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "name_book"
    t.string "description"
    t.string "author"
    t.integer "quantity"
    t.integer "price"
    t.string "image"
    t.bigserial "category_id", null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name_category"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discount_details", force: :cascade do |t|
    t.bigserial "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigserial "discount_id", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name_KM"
    t.float "gia_KM"
    t.date "start_day"
    t.date "end_day"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "evaluaters", force: :cascade do |t|
    t.integer "book_id"
    t.integer "level"
    t.integer "user_id"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_details", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "book_id"
    t.float "price"
    t.integer "quantity"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id"
    t.string "address"
    t.string "phone"
    t.integer "status"
    t.float "total_price"
    t.float "total_discount"
    t.date "expiry_date"
    t.integer "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "address"
    t.integer "type_account"
    t.string "phone"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "provider"
  end

  add_foreign_key "discount_details", "books"
  add_foreign_key "discount_details", "discounts"
  add_foreign_key "evaluaters", "books"
  add_foreign_key "evaluaters", "users"
  add_foreign_key "invoices", "users"
end
