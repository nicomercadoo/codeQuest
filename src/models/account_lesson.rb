# frozen_string_literal: true

class AccountLesson < ActiveRecord::Base
  validates :lesson_completed, inclusion: { in: [true, false] }

  belongs_to :account
  belongs_to :lesson

  after_commit :actualizar_progreso_account

  private

  def actualizar_progreso_account
    account.actualizar_progreso
  end

  def self.complete_lesson(lesson_id, account_id)
    accounts_lesson = find_by(lesson_id: lesson_id, account_id: account_id)
    accounts_lesson&.update(lesson_completed: true)
  end
  
end
