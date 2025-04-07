require "test_helper"

module Templates
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {
        title: "My template",
        group: "expense",
        account: create(:account),
        category: create(:category),
        amount_cents: 200,
        note: "Testing"
      }

      result = Template.stub :next_position, 812 do
        Templates::Create.call(attributes:)
      end

      assert_instance_of Templates::Create::Success, result
      assert result.template.persisted?

      attributes.each do |attribute, value|
        assert_equal value, result.template.public_send(attribute)
      end
      assert_equal 812, result.template.position
    end

    test "failure" do
      attributes = {title: nil}

      result = Templates::Create.call(attributes:)

      assert_instance_of Templates::Create::Failure, result
      refute result.template.persisted?
      assert result.template.errors.any?
    end
  end
end
