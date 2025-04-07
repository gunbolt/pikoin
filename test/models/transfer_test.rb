require "test_helper"

class TransferTest < ActiveSupport::TestCase
  test "associations" do
    transfer = Transfer.new

    assert belong_to(:from_account)
      .class_name("Account")
      .required(true)
      .matches?(transfer)

    assert belong_to(:to_account)
      .class_name("Account")
      .required(true)
      .matches?(transfer)
  end

  test "validations" do
    transfer = Transfer.new

    assert validate_presence_of(:occurred_on).matches?(transfer)
    assert validate_presence_of(:note).allow_blank.matches?(transfer)

    assert validate_numericality_of(:amount_cents)
      .is_greater_than(0)
      .matches?(transfer)

    assert validate_length_of(:note).is_at_most(32).matches?(transfer)
  end

  test "from_account validation" do
    error_message = I18n.t("activerecord.errors.models.transfer.must_be_different_from_origin_account")
    account_a = create(:account)
    account_b = create(:account)
    transfer = Transfer.new(
      from_account: account_a,
      to_account: account_a
    )

    transfer.validate

    assert_includes transfer.errors[:to_account_id], error_message

    transfer.to_account = account_b

    transfer.validate

    assert_empty transfer.errors[:to_account_id]
  end

  test "#attributes_for_expense_record" do
    transfer = Transfer.new(
      id: 59,
      from_account_id: 42,
      to_account_id: 64,
      amount_cents: 95_25,
      occurred_on: Date.parse("2020-01-01"),
      note: "Some transfer",
      created_at: 3.days.ago,
      updated_at: 2.days.ago
    )

    expected_attributes = {
      transfer_id: 59,
      amount_cents: 95_25,
      occurred_on: Date.parse("2020-01-01"),
      note: "Some transfer",
      group: "expense",
      account_id: 42,
      created_at: transfer.created_at,
      updated_at: transfer.updated_at
    }

    assert_equal expected_attributes, transfer.attributes_for_expense_record
  end

  test "#attributes_for_income_record" do
    transfer = Transfer.new(
      id: 59,
      from_account_id: 42,
      to_account_id: 64,
      amount_cents: 95_25,
      occurred_on: Date.parse("2020-01-01"),
      note: "Some transfer",
      created_at: 3.days.ago,
      updated_at: 2.days.ago
    )

    expected_attributes = {
      transfer_id: 59,
      amount_cents: 95_25,
      occurred_on: Date.parse("2020-01-01"),
      note: "Some transfer",
      group: "income",
      account_id: 64,
      created_at: transfer.created_at,
      updated_at: transfer.updated_at
    }

    assert_equal expected_attributes, transfer.attributes_for_income_record
  end
end
