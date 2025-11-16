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

ActiveRecord::Schema[8.1].define(version: 2025_11_15_120000) do
  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "isbn", null: false
    t.integer "stock", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
  end

  create_table "borrowers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "id_card_number", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["id_card_number"], name: "index_borrowers_on_id_card_number", unique: true
  end

  create_table "loans", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "borrowed_at", precision: nil, null: false
    t.integer "borrower_id", null: false
    t.datetime "created_at", null: false
    t.datetime "due_date", precision: nil, null: false
    t.datetime "returned_at", precision: nil
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["borrower_id"], name: "index_loans_on_borrower_id"
  end

  add_foreign_key "loans", "books"
  add_foreign_key "loans", "borrowers"
end
