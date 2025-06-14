require "test_helper"

class ReminderMonthlyConfigTest < ActiveSupport::TestCase
  test "associations" do
    config = ReminderMonthlyConfig.new

    assert have_one(:reminder).touch(true).matches?(config)
  end

  test "validations" do
    config = ReminderMonthlyConfig.new

    assert validate_inclusion_of(:day).in_range(1..28).matches?(config)
  end
end
