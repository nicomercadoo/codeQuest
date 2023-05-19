class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.integer :name
      t.string :tittle
      t.boolean :completed, default: false
      t.text :description

      t.timestamps
    end
  end
end