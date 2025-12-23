# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.integer :number
      t.string :title
      t.string :test_letter # Columna que referencia la letra del test al que pertenece

      t.timestamps
    end
  end
end
