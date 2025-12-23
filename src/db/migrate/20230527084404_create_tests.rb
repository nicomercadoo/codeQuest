# frozen_string_literal: true

class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :letter, limit: 1, unique: true # Clave que usaremos como única
      t.string :description
      t.integer :cant_questions, default: 0

      t.timestamps
    end

    add_index :tests, :letter, unique: true
  end
end
