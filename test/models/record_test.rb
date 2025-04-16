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

    travel_to Date.new(2020, 1, 15) do
      assert validate_comparison_of(:occurred_on)
        .is_less_than_or_equal_to(Date.new(2020, 1, 15))
    end
  end

  test "category validation" do
    record = Record.new(transfer_id: 2)
    assert validate_absence_of(:category).matches?(record)

    record = Record.new(transfer_id: nil)
    assert validate_presence_of(:category).matches?(record)
  end

  test ".on scope" do
    record_a = create(:income, occurred_on: 1.day.ago)
    record_b = create(:expense, occurred_on: 2.days.ago)
    record_c = create(:income, occurred_on: 1.month.ago)

    assert_equal [record_a], Record.on(1.day.ago).to_a
    assert_equal [record_b], Record.on(2.days.ago).to_a
    assert_equal [record_a, record_b, record_c],
      Record.on(2.months.ago..Time.zone.today).to_a
  end

  test ".without_transfers scope" do
    record_a = create(:income)
    record_b = create(:expense)
    transfer = create(:transfer)

    result = Record.without_transfers.to_a

    assert_includes result, record_a
    assert_includes result, record_b
    refute_includes result, transfer.expense_record
    refute_includes result, transfer.income_record
  end

  test ".total_amount" do
    create(:income, amount_cents: 200_00)
    create(:expense, amount_cents: 150_00)

    assert_equal Money.new(50_00), Record.total
    assert_equal Money.new(200_00), Record.income.total
    assert_equal Money.new(-150_00), Record.expense.total
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
