class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.text :title, null: false
      t.text :color, null: false
      t.integer :initial_amount_cents, default: 0, null: false
      t.boolean :archived, null: false, default: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
