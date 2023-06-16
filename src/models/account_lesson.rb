class AccountLesson < ActiveRecord::Base
  validates :lesson_completed, inclusion: { in: [true, false] }

  belongs_to :account
  belongs_to :lesson

  after_commit :actualizar_progreso_account

  private

  def actualizar_progreso_account
    account.actualizar_progreso
  end
end