class AddAnswerRefToOptions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :options, :answers, column: :answer_number, primary_key: :number
  end
end

