require "test_helper"

class ReminderOccurrenceTest < ActiveSupport::TestCase
  test "associations" do
    occurrence = ReminderOccurrence.new

    assert belong_to(:reminder).matches?(occurrence)
    assert belong_to(:record).optional(true).matches?(occurrence)
  end

  test "enums" do
    occurrence = ReminderOccurrence.new

    assert define_enum_for(:state)
      .with_values(pending: "pending", settled: "settled", dismissed: "dismissed")
      .backed_by_column_of_type(:text)
      .with_default(:pending)
      .validating
      .matches?(occurrence)
  end

  test "validations" do
    occurrence = ReminderOccurrence.new

    assert validate_presence_of(:occurs_on).matches?(occurrence)
  end
end
