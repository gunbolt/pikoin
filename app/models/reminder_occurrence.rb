class ReminderOccurrence < ApplicationRecord
  enum :state,
    {pending: "pending", settled: "settled", dismissed: "dismissed"},
    default: :pending,
    validate: true

  belongs_to :reminder
  belongs_to :record, optional: true

  validates :occurs_on, presence: true
end
