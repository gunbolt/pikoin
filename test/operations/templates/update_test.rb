require "test_helper"

module Templates
  class UpdateTest < ActiveSupport::TestCase
    test "success" do
      id = create(:template).id
      attributes = {amount_cents: 888}

      result = Templates::Update.call(id:, attributes:)

      assert_instance_of Templates::Update::Success, result
      assert result.template.valid?
      assert_equal 888, result.template.amount_cents
    end

    test "failure" do
      id = create(:template).id
      attributes = {title: nil}

      result = Templates::Update.call(id:, attributes:)

      assert_instance_of Templates::Update::Failure, result
      refute result.template.valid?
      assert result.template.errors.any?
    end

    test "not found" do
      id = "not-found"
      attributes = {amount_cents: 888}

      assert_raises ActiveRecord::RecordNotFound do
        Templates::Update.call(id:, attributes:)
      end
    end
  end
end
