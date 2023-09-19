class CreateSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :snippets do |t|
      t.text :description
      t.text :code

      t.timestamps
    end
  end
end
