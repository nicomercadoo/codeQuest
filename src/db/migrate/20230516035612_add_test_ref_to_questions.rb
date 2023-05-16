class AddTestRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :tests, foreing_key: true
  end
end
