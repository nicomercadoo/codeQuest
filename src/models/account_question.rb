class AccountQuestion < ActiveRecord::Base
  validates :well_answered, inclusion: { in: [true, false] }
  
  belongs_to :account
  belongs_to :question

  after_commit :actualizar_progreso_account

  private

  def actualizar_progreso_account
    account.actualizar_progreso
  end
end