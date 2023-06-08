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

ActiveRecord::Schema[7.0].define(version: 2023_06_08_064947) do
  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "nickname"
    t.integer "progress", default: 0
    t.boolean "theme_light", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts_lessons", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "lesson_id", null: false
    t.boolean "lesson_completed", default: false
  end

  create_table "accounts_options", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "option_id", null: false
  end

  create_table "accounts_questions", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "question_id", null: false
    t.boolean "well_answered", default: false
  end

  create_table "accounts_tests", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "test_id", null: false
    t.boolean "test_completed", default: false
    t.integer "correct_questions", default: 0
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.text "description"
    t.string "test_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer "number"
    t.boolean "correct", default: false
    t.text "description"
    t.integer "question_number"
    t.string "test_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "number"
    t.text "description"
    t.string "test_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "letter", limit: 1
    t.string "description"
    t.integer "cant_questions", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["letter"], name: "index_tests_on_letter", unique: true
  end

end
