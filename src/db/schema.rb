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

ActiveRecord::Schema[7.0].define(version: 2023_05_27_160821) do
  create_table "accounts", primary_key: "nickname", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", primary_key: "number", force: :cascade do |t|
    t.text "description"
    t.string "account_nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", primary_key: "number", force: :cascade do |t|
    t.string "title"
    t.boolean "completed", default: false
    t.text "description"
    t.string "account_nickname"
    t.string "test_letter", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", primary_key: "number", force: :cascade do |t|
    t.boolean "correct", default: false
    t.text "description"
    t.integer "question_number"
    t.integer "answer_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", primary_key: "number", force: :cascade do |t|
    t.text "description"
    t.boolean "well_answered", default: false
    t.string "test_letter", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", primary_key: "letter", id: { type: :string, limit: 1 }, force: :cascade do |t|
    t.string "description"
    t.boolean "completed", default: false
    t.integer "cant_questions", default: 0
    t.integer "acerted_answers", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "accounts", column: "account_nickname", primary_key: "nickname"
  add_foreign_key "lessons", "accounts", column: "account_nickname", primary_key: "nickname"
  add_foreign_key "lessons", "tests", column: "test_letter", primary_key: "letter"
  add_foreign_key "options", "answers", column: "answer_number", primary_key: "number"
  add_foreign_key "options", "questions", column: "question_number", primary_key: "number"
  add_foreign_key "questions", "tests", column: "test_letter", primary_key: "letter"
end
