class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title_question
      t.text :description_question
      t.boolean :correct_question, default: false

      t.timestamps
    end
  end
end
