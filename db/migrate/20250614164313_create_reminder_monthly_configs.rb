class CreateReminderMonthlyConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :reminder_monthly_configs do |t|
      t.integer :day, null: false

      t.timestamps
    end
  end
end
