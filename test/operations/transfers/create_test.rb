require "test_helper"

module Transfers
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {
        from_account: create(:account),
        to_account: create(:account),
        amount_cents: 200,
        occurred_on: Date.parse("2025-02-03")
      }

      result = Transfers::Create.call(attributes:)

      transfer = result.transfer

      assert_instance_of Transfers::Create::Success, result
      assert transfer.persisted?

      attributes.each do |attribute, value|
        assert_equal value, transfer.public_send(attribute)
      end

      transfer.attributes_for_expense_record.each do |attribute, value|
        assert_equal value, transfer.expense_record.public_send(attribute)
      end

      transfer.attributes_for_income_record.each do |attribute, value|
        assert_equal value, transfer.income_record.public_send(attribute)
      end
    end

    test "failure" do
      attributes = {amount_cents: nil}

      result = Transfers::Create.call(attributes:)

      assert_instance_of Transfers::Create::Failure, result
      refute result.transfer.persisted?
      assert result.transfer.errors.any?
      assert_nil result.transfer.expense_record
      assert_nil result.transfer.income_record
    end
  end
end
