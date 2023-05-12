class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :fisrt_name
      t.string :last_name
      t.string :password
      t.integer :progress
      t.string :nickname

      t.timestamps
    end
  end
end
