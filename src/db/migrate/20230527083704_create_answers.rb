class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: false do |t|
      t.integer :number, primary_key: true 
      t.text :description
      t.string :account_nickname

      t.timestamps
    end
  end
end
