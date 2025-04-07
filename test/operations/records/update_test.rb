require "test_helper"

module Records
  class UpdateTest < ActiveSupport::TestCase
    test "success" do
      id = create(:record).id
      attributes = {amount_cents: 888}

      result = Records::Update.call(id:, attributes:)

      assert_instance_of Records::Update::Success, result
      assert result.record.valid?
      assert_equal 888, result.record.amount_cents
    end

    test "failure" do
      id = create(:record).id
      attributes = {amount_cents: nil}

      result = Records::Update.call(id:, attributes:)

      assert_instance_of Records::Update::Failure, result
      refute result.record.valid?
      assert result.record.errors.any?
    end

    test "not found" do
      id = "not-found"
      attributes = {amount_cents: 888}

      assert_raises ActiveRecord::RecordNotFound do
        Records::Update.call(id:, attributes:)
      end
    end
  end
end
