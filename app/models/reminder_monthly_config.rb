class ReminderMonthlyConfig < ApplicationRecord
  include ReminderConfig

  validates :day, inclusion: {in: 1..28}
end
