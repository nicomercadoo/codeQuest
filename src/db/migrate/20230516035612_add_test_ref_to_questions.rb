class AddTestRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :tests, foreign_key: true
  end
end
