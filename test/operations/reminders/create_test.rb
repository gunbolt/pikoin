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

      assert_instance_of Reminders::Create::Success, result
      assert result.reminder.persisted?

      attributes.except(:config_attributes).each do |attribute, value|
        assert_equal value, result.reminder.public_send(attribute)
      end
      attributes[:config_attributes].each do |attribute, value|
        assert_equal value, result.reminder.config.public_send(attribute)
      end
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
