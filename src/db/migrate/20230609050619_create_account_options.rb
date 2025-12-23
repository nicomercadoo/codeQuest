# frozen_string_literal: true

class CreateAccountOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_options do |t|
      t.references :account, foreign_key: true
      t.references :option, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
