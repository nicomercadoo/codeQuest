class AddAccountRefToLessons < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :lessons, :accounts, column: :account_nickname, primary_key: :nickname
  end
end
