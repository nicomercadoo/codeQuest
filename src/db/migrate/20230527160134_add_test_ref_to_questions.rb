class AddTestRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :questions, :tests, column: :test_letter, primary_key: :letter
  end
end
