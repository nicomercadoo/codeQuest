class AddAccountAndTestRefToLessons < ActiveRecord::Migration[7.0]
  def change    
    add_reference :lessons, :accounts, foreign_key: true     
    add_reference :lessons, :tests, foreign_key: true
  end
end
