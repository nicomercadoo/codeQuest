# frozen_string_literal: true

class AccountTest < ActiveRecord::Base
  validates :test_completed, inclusion: { in: [true, false] }
  validates :correct_questions, presence: true

  belongs_to :account
  belongs_to :test

  after_commit :actualizar_progreso_account

  private

  def actualizar_progreso_account
    account.actualizar_progreso
  end

  def check_and_update_test_completion(account_id, test_id, questions, test_letter)
    existing_account_test = find_by(account_id: account_id, test_id: test_id)
    if !AccountQuestion.where(account_id: account_id, question_id: questions.where(test_letter: test_letter), well_answered: false).exists?
      existing_account_test.update(test_completed: true)
    else
      existing_account_test.update(test_completed: false)
    end
  end

end
