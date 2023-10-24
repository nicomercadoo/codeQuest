# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.integer :number
      t.boolean :correct, default: false
      t.text :description
      t.integer :question_number, foreign_key: true # Columna que referencia a la pregunta a la que pertenece
      t.string :test_letter, foreign_key: true

      t.timestamps
    end
  end
end
