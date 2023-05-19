class AddDescriptionToTest < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :description, :string
  end
end
