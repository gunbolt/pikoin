class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.text :title, null: false
      t.text :color, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
