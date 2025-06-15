class ReminderOccurrence < ApplicationRecord
  belongs_to :reminder
  belongs_to :record, optional: true

  validates :occurs_on, presence: true
end
