class AddAnswerAndQuestionRefToOptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :options, :answers, foreign_key: true
    add_reference :options, :questions, foreign_key: true
  end
end
