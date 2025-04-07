class CreateRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :records do |t|
      t.references :account, null: false, foreign_key: true
      t.references :transfer, null: true, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.integer :group, null: false
      t.integer :amount_cents, default: 0, null: false
      t.date :occurred_on, null: false
      t.text :note, null: false, default: ""

      t.timestamps
    end
  end
end
