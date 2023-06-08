class CreateAccountsTestsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :accounts, :tests do |t|
      t.boolean :test_completed, default: false
      t.integer :correct_questions, default: 0
    end
  end
end
