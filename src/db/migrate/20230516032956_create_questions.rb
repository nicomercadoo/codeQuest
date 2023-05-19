class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :number
      t.text :description
      t.boolean :well_answered, default: false

      t.timestamps
    end
  end
end