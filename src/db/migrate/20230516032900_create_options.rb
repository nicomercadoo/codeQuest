class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.boolean :correct, default: false
      t.text :description

      t.timestamps
    end
  end
end