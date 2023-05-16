class AddTestRefToLessons < ActiveRecord::Migration[7.0]
  def change
    add_reference :lessons, :tests, foreing_key: true
  end
end
