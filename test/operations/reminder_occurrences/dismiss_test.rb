require "test_helper"

module ReminderOccurrences
  class DismissTest < ActiveSupport::TestCase
    test "success" do
      occurrence = create(:reminder_occurrence, :pending)
      reminder = occurrence.reminder

      result = ReminderOccurrences::Dismiss.call(id: occurrence.id)

      assert_instance_of ReminderOccurrences::Dismiss::Success, result
      assert occurrence.reload.dismissed?

      assert_equal 2, reminder.occurrences.count
      assert reminder.occurrences
        .where(occurs_on: reminder.next_occurrence_date)
        .any?
    end

    test "failure when occurrence is not pending" do
      occurrence = create(:reminder_occurrence, :dismissed)
      result = ReminderOccurrences::Dismiss.call(id: occurrence.id)
      assert_instance_of ReminderOccurrences::Dismiss::Failure, result
      assert occurrence.reload.dismissed?

      occurrence = create(:reminder_occurrence, :settled)
      result = ReminderOccurrences::Dismiss.call(id: occurrence.id)
      assert_instance_of ReminderOccurrences::Dismiss::Failure, result
      assert occurrence.reload.settled?
    end

    test "failure when cannot dismiss occurrence" do
      occurrence = create(:reminder_occurrence, :pending)
      reminder = occurrence.reminder

      ReminderOccurrence.stub :find, occurrence do
        occurrence.stub :dismissed!, -> { raise "some error" } do
          result = ReminderOccurrences::Dismiss.call(id: occurrence.id)

          assert_instance_of ReminderOccurrences::Dismiss::Failure, result
          assert occurrence.reload.pending?

          assert_equal 1, reminder.occurrences.count
        end
      end
    end
  end
end
