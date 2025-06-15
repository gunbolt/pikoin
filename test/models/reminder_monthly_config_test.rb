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

  test "#next_occurrence_date" do
    travel_to Date.new(2025, 6, 15) do
      config = ReminderMonthlyConfig.new(day: 14)
      assert_equal Date.new(2025, 7, 14), config.next_occurrence_date

      config.day = 15
      assert_equal Date.new(2025, 7, 15), config.next_occurrence_date

      config.day = 16
      assert_equal Date.new(2025, 6, 16), config.next_occurrence_date
    end
  end
end
