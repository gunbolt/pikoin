require "test_helper"

module Transfers
  class UpdateTest < ActiveSupport::TestCase
    test "success" do
      id = create(:transfer).id
      attributes = {amount_cents: 888}

      result = Transfers::Update.call(id:, attributes:)

      assert_instance_of Transfers::Update::Success, result
      assert result.transfer.valid?
      assert_equal 888, result.transfer.amount_cents
      assert_equal 888, result.transfer.income_record.amount_cents
      assert_equal 888, result.transfer.expense_record.amount_cents
    end

    test "failure" do
      id = create(:transfer).id
      attributes = {amount_cents: nil}

      result = Transfers::Update.call(id:, attributes:)

      assert_instance_of Transfers::Update::Failure, result
      refute result.transfer.valid?
      assert result.transfer.errors.any?
    end

    test "not found" do
      id = "not-found"
      attributes = {amount_cents: 888}

      assert_raises ActiveRecord::RecordNotFound do
        Transfers::Update.call(id:, attributes:)
      end
    end
  end
end
