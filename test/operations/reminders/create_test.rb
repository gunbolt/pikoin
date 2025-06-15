require "test_helper"

module Reminders
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {
        title: "My reminder",
        group: "expense",
        account: create(:account),
        category: create(:category),
        amount_cents: 200,
        note: "Testing",
        config_type: "ReminderMonthlyConfig",
        config_attributes: {day: 24}
      }

      result = Reminders::Create.call(attributes:)
      reminder = result.reminder

      assert_instance_of Reminders::Create::Success, result
      assert reminder.persisted?

      attributes.except(:config_attributes).each do |attribute, value|
        assert_equal value, reminder.public_send(attribute)
      end
      attributes[:config_attributes].each do |attribute, value|
        assert_equal value, reminder.config.public_send(attribute)
      end

      assert_equal 1, reminder.occurrences.count
      assert reminder.occurrences
        .where(occurs_on: reminder.next_occurrence_date)
        .any?
    end

    test "failure" do
      attributes = {title: nil}

      result = Reminders::Create.call(attributes:)

      assert_instance_of Reminders::Create::Failure, result
      refute result.reminder.persisted?
      assert result.reminder.errors.any?
    end
  end
end
