class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons, id: false do |t|
      t.integer :number, primary_key: true
      t.string :title
      t.boolean :completed, default: false
      t.text :description
      t.string :account_nickname
      t.string :test_letter, limit: 1

      t.timestamps
    end
  end
end
