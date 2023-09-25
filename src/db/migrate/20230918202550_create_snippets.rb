class CreateSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :snippets do |t|
      t.text :description
      t.text :code
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
