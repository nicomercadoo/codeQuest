class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :description_question
      t.boolean :well_answered, default: false

      t.timestamps
    end
  end
end