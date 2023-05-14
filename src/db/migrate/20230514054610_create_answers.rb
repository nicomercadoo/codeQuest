class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :description_answer

      t.timestamps
    end
  end
end
