class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.boolean :correct_option, default: false
      t.text :description_option

      t.timestamps
    end
  end
end