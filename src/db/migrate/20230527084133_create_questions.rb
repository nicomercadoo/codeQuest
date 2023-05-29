class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: false do |t|
      t.integer :number, primary_key: true
      t.text :description
      t.boolean :well_answered, default: false
      t.string :test_letter, limit: 1

      t.timestamps
    end
  end
end
