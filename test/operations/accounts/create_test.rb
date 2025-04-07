require "test_helper"

module Accounts
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {
        title: "My account",
        color: "#000123",
        initial_amount_cents: 20_00
      }

      result = Account.stub :next_position, 123 do
        Accounts::Create.call(attributes:)
      end

      assert_instance_of Accounts::Create::Success, result
      assert result.account.persisted?
      assert_equal "My account", result.account.title
      assert_equal "#000123", result.account.color
      assert_equal 123, result.account.position
    end

    test "failure" do
      attributes = {title: nil}

      result = Accounts::Create.call(attributes:)

      assert_instance_of Accounts::Create::Failure, result
      refute result.account.persisted?
      assert result.account.errors.any?
    end
  end
end
