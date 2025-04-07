require "test_helper"

module Categories
  class CreateTest < ActiveSupport::TestCase
    test "success" do
      attributes = {title: "My category", color: "#000123"}

      result = Category.stub :next_position, 543 do
        Categories::Create.call(attributes:)
      end

      assert_instance_of Categories::Create::Success, result
      assert result.category.persisted?
      assert_equal "My category", result.category.title
      assert_equal "#000123", result.category.color
      assert_equal 543, result.category.position
    end

    test "failure" do
      attributes = {title: nil}

      result = Categories::Create.call(attributes:)

      assert_instance_of Categories::Create::Failure, result
      refute result.category.persisted?
      assert result.category.errors.any?
    end
  end
end
