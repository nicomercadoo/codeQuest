class AccountOption < ActiveRecord::Base
  belongs_to :account
  belongs_to :option
  belongs_to :question

  after_commit :actualizar_progreso_account

  private

  def actualizar_progreso_account
    account.actualizar_progreso
  end
end