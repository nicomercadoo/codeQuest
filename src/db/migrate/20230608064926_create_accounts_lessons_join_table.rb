class CreateAccountsLessonsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :accounts, :lessons do |t|
      t.boolean :lesson_completed, default: false
    end
  end
end
