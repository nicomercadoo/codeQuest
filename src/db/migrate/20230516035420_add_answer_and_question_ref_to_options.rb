class AddAnswerAndQuestionRefToOptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :options, :answers, foreing_key: true
    add_reference :options, :questions, foreing_key: true
  end
end
