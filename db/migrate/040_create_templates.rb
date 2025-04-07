class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.text :title, null: false
      t.integer :group, null: false
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :amount_cents, default: 0, null: false
      t.text :note
      t.integer :position, null: false

      t.timestamps
    end

    add_index :templates, :title, unique: true
  end
end
