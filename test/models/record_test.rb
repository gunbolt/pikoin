require "test_helper"

class RecordTest < ActiveSupport::TestCase
  test "associations" do
    record = Record.new

    assert belong_to(:account).required(true).matches?(record)
    assert belong_to(:transfer).optional(true).matches?(record)
  end

  test "validations" do
    record = Record.new

    assert validate_presence_of(:occurred_on).matches?(record)
    assert validate_presence_of(:note).allow_blank.matches?(record)

    assert validate_numericality_of(:amount_cents)
      .is_greater_than(0)
      .matches?(record)

    assert validate_length_of(:note).is_at_most(32).matches?(record)
  end

  test "category validation" do
    record = Record.new(transfer_id: 2)
    assert validate_absence_of(:category).matches?(record)

    record = Record.new(transfer_id: nil)
    assert validate_presence_of(:category).matches?(record)
  end

  test "without_transfer scope" do
    record_a = create(:record, :income)
    record_b = create(:record, :expense)
    transfer = create(:transfer)

    result = Record.without_transfer.to_a

    assert_includes result, record_a
    assert_includes result, record_b
    refute_includes result, transfer.expense_record
    refute_includes result, transfer.income_record
  end

  test ".total_amount" do
    create(:record, :income, amount_cents: 200_00)
    create(:record, :expense, amount_cents: 150_00)

    assert_equal Money.new(50_00), Record.total_amount
    assert_equal Money.new(200_00), Record.income.total_amount
    assert_equal Money.new(-150_00), Record.expense.total_amount
  end

  test "#amount" do
    expense = Record.new(
      group: :expense,
      amount_cents: 1234
    )
    income = Record.new(
      group: :income,
      amount_cents: 1234
    )

    assert_equal Money.new(-1234), expense.amount
    assert_equal Money.new(1234), income.amount
  end
end
