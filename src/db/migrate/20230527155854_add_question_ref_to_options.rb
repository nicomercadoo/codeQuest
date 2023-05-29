class AddQuestionRefToOptions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :options, :questions, column: :question_number, primary_key: :number
  end
end
