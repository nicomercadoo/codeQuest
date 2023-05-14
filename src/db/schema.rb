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

ActiveRecord::Schema[7.0].define(version: 2023_05_14_054709) do
  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.text "description_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "number_lesson"
    t.boolean "completed_lesson", default: false
    t.string "title_lesson"
    t.text "description_lesson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.boolean "correct_option", default: false
    t.text "description_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title_question"
    t.text "description_question"
    t.boolean "correct_question", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "letter"
    t.boolean "completed_test", default: false
    t.string "title_test"
    t.text "description_test"
    t.integer "cant_questions", default: 0
    t.integer "acerted_answers", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
