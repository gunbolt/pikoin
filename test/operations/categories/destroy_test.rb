require "test_helper"

module Categories
  class DestroyTest < ActiveSupport::TestCase
    test "success" do
      id = create(:category).id

      result = Categories::Destroy.call(id:)

      assert_instance_of Categories::Destroy::Success, result
      assert result.category.destroyed?
    end

    test "failure" do
      id = "not-found"

      assert_raises ActiveRecord::RecordNotFound do
        Categories::Destroy.call(id:)
      end
    end
  end
end
