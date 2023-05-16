class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email 
      t.string :password
      t.string :nickname
      t.integer :progress, default: 0

      t.timestamps
    end
  end 
end