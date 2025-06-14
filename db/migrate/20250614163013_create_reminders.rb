class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.text :title, null: false
      t.integer :group, null: false
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :amount_cents, default: 0, null: false
      t.text :note, default: "", null: false
      t.references :config, polymorphic: true, null: false

      t.timestamps
    end

    add_index :reminders, :title, unique: true
  end
end
