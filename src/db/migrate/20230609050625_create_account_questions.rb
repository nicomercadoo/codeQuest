class CreateAccountQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_questions do |t|
      t.boolean :well_answered, default: false
      t.references :account, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
