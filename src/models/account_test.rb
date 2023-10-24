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
end
