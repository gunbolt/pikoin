require "test_helper"

module Categories
  class UpdateTest < ActiveSupport::TestCase
    test "success" do
      id = create(:category).id
      attributes = {title: "Updated title", color: "#987543"}

      result = Categories::Update.call(id:, attributes:)

      assert_instance_of Categories::Update::Success, result
      assert result.category.valid?
      assert_equal "Updated title", result.category.title
      assert_equal "#987543", result.category.color
    end

    test "failure" do
      id = create(:category).id
      attributes = {title: nil}

      result = Categories::Update.call(id:, attributes:)

      assert_instance_of Categories::Update::Failure, result
      refute result.category.valid?
      assert result.category.errors.any?
    end

    test "not found" do
      id = "not-found"
      attributes = {title: "Updated title", color: "#987543"}

      assert_raises ActiveRecord::RecordNotFound do
        Categories::Update.call(id:, attributes:)
      end
    end
  end
end
