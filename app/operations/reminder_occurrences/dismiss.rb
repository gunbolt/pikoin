module ReminderOccurrences
  class Dismiss < ApplicationOperation
    prop :id, Id

    Success = Result.define(occurrence: ReminderOccurrence)
    Failure = Result.define(occurrence: ReminderOccurrence)

    def call
      occurrence = ReminderOccurrence.find(@id)

      return Failure[occurrence:] if !occurrence.pending?

      reminder = occurrence.reminder

      ReminderOccurrence.transaction do
        occurrence.dismissed!
        reminder.occurrences.create!(occurs_on: reminder.next_occurrence_date(base_date: occurrence.occurs_on))

        Success[occurrence:]
      rescue
        Failure[occurrence:]
      end
    end
  end
end
