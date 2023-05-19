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

ActiveRecord::Schema[7.0].define(version: 2023_05_19_163744) do
  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "nickname"
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accounts_id"
    t.index ["accounts_id"], name: "index_answers_on_accounts_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "name"
    t.string "tittle"
    t.boolean "completed", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accounts_id"
    t.integer "tests_id"
    t.index ["accounts_id"], name: "index_lessons_on_accounts_id"
    t.index ["tests_id"], name: "index_lessons_on_tests_id"
  end

  create_table "options", force: :cascade do |t|
    t.boolean "correct", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answers_id"
    t.integer "questions_id"
    t.index ["answers_id"], name: "index_options_on_answers_id"
    t.index ["questions_id"], name: "index_options_on_questions_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "number"
    t.text "description"
    t.boolean "well_answered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tests_id"
    t.index ["tests_id"], name: "index_questions_on_tests_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name", limit: 1
    t.boolean "completed", default: false
    t.integer "cant_questions", default: 0
    t.integer "acerted_answers", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

end
