class RemoveFromAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :fisrt_name, :string
    remove_column :accounts, :last_name, :string
    remove_column :accounts, :progress, :integer
  end
end
