class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :letter, limit: 1
      t.boolean :completed_test, default: false
      t.text :description_test
      t.integer :cant_questions, default: 0
      t.integer :acerted_answers, default: 0

      t.timestamps
    end
  end
end
