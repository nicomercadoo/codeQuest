class CreateAccountLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :account_lessons do |t|
      t.boolean :lesson_completed, default: false
      t.references :account, foreign_key: true
      t.references :lesson, foreign_key: true

      t.timestamps
    end
  end
end
