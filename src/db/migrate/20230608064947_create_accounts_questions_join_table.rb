class CreateAccountsQuestionsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :accounts, :questions do |t|
      t.boolean :well_answered, default: false
    end
  end
end
