class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options, id: false do |t|
      t.integer :number, primary_key: true
      t.boolean :correct, default: false
      t.text :description
      t.integer :question_number
      t.integer :answer_number

      t.timestamps
    end
  end
end
