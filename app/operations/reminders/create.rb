module Reminders
  class Create < ApplicationOperation
    prop :attributes, Hash

    Success = Data.define(:reminder)
    Failure = Data.define(:reminder)

    def call
      reminder = Reminder.new(@attributes)

      Reminder.transaction do
        reminder.save!
        reminder.occurrences.create!(occurs_on: reminder.next_occurrence_date)

        Success[reminder:]
      rescue
        Failure[reminder:]
      end
    end
  end
end
