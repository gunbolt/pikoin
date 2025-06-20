require "test_helper"

class ReminderTest < ActiveSupport::TestCase
  test "associations" do
    reminder = Reminder.new

    assert belong_to(:account).matches?(reminder)
    assert belong_to(:category).matches?(reminder)

    assert have_many(:occurrences)
      .class_name("ReminderOccurrence")
      .dependent(:destroy)
      .matches?(reminder)
  end

  test "delegated types" do
    reminder = Reminder.new

    assert have_delegated_type(:config)
      .types(%w[ReminderMonthlyConfig])
      .matches?(reminder)
  end

  test "delegated methods" do
    reminder = Reminder.new

    assert delegate_method(:description).to(:config).matches?(reminder)
    assert delegate_method(:next_occurrence_date).to(:config).matches?(reminder)
  end

  test "validations" do
    reminder = create(:reminder)

    assert validate_presence_of(:title).matches?(reminder)

    assert validate_uniqueness_of(:title).case_insensitive.matches?(reminder)

    assert validate_numericality_of(:amount_cents)
      .is_greater_than_or_equal_to(0)
      .matches?(reminder)

    assert validate_length_of(:title).is_at_most(40).matches?(reminder)

    assert validate_length_of(:note)
      .is_at_most(32)
      .allow_nil
      .matches?(reminder)
  end

  test "#amount" do
    reminder_a = Reminder.new(group: :expense, amount_cents: 1234)
    reminder_b = Reminder.new(group: :income, amount_cents: 1234)
    no_amount = Reminder.new(group: :expense, amount_cents: 0)

    assert_equal Money.new(-12_34), reminder_a.amount
    assert_equal Money.new(12_34), reminder_b.amount
    assert no_amount.amount.zero?
  end

  test "#next_occurrence_date" do
    reminder = build_stubbed(:reminder)

    assert_equal reminder.config.next_occurrence_date,
      reminder.next_occurrence_date
  end
end
