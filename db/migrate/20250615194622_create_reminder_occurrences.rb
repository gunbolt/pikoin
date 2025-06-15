class CreateReminderOccurrences < ActiveRecord::Migration[8.0]
  def change
    create_table :reminder_occurrences do |t|
      t.references :reminder, null: false, foreign_key: true
      t.references :record, null: true, foreign_key: true
      t.date :occurs_on, null: false
      t.boolean :dismissed, default: false, null: false

      t.timestamps
    end
  end
end
