require "test_helper"

module Records
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {
        group: "expense",
        account: create(:account),
        category: create(:category),
        amount_cents: 200,
        occurred_on: Date.parse("2025-02-03")
      }

      result = Records::Create.call(attributes:)

      assert_instance_of Records::Create::Success, result
      assert result.record.persisted?

      attributes.each do |attribute, value|
        assert_equal value, result.record.public_send(attribute)
      end
    end

    test "failure" do
      attributes = {amount_cents: nil}

      result = Records::Create.call(attributes:)

      assert_instance_of Records::Create::Failure, result
      refute result.record.persisted?
      assert result.record.errors.any?
    end
  end
end
