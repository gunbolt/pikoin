require "test_helper"

class ReminderOccurrenceTest < ActiveSupport::TestCase
  test "associations" do
    occurrence = ReminderOccurrence.new

    assert belong_to(:reminder).matches?(occurrence)
    assert belong_to(:record).optional(true).matches?(occurrence)
  end

  test "validations" do
    occurrence = ReminderOccurrence.new

    assert validate_presence_of(:occurs_on).matches?(occurrence)
  end
end
