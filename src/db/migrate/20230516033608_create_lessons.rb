class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.integer :name_lesson
      t.boolean :completed_lesson, default: false
      t.text :description_lesson

      t.timestamps
    end
  end
end