class CreateAccountSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :account_snippets do |t|
      t.references :account, foreign_key: true
      t.references :snippet, foreign_key: true

      t.timestamps
    end
  end
end
