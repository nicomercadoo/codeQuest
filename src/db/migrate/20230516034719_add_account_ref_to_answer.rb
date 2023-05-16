class AddAccountRefToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :accounts, foreing_key: true
  end
end
