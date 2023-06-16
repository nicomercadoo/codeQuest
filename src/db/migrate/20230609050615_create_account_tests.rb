class CreateAccountTests < ActiveRecord::Migration[7.0]
  def change
    create_table :account_tests do |t|
      t.boolean :test_completed, default: false
      t.integer :correct_questions, default: 0
      t.references :account, foreign_key: true
      t.references :test, foreign_key: true

      t.timestamps
    end
  end
end
