class ReminderOccurrence < ApplicationRecord
  enum :state,
    {pending: "pending", settled: "settled", dismissed: "dismissed"},
    default: :pending,
    validate: true

  belongs_to :reminder
  belongs_to :record, optional: true

  validates :occurs_on, presence: true

  def state_humanize
    I18n.t(state, scope: "enums.reminder_occurrence.state")
  end
end
