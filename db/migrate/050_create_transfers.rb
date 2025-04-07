class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.references :from_account,
        null: false,
        foreign_key: {to_table: :accounts}

      t.references :to_account,
        null: false,
        foreign_key: {to_table: :accounts}

      t.integer :amount_cents, default: 0, null: false
      t.date :occurred_on, null: false
      t.text :note, null: false, default: ""

      t.timestamps
    end
  end
end
