require "test_helper"

module Templates
  class DestroyTest < ActiveSupport::TestCase
    test "success" do
      id = create(:template).id

      result = Templates::Destroy.call(id:)

      assert_instance_of Templates::Destroy::Success, result
      assert result.template.destroyed?
    end

    test "not found" do
      id = "not-found"

      assert_raises ActiveRecord::RecordNotFound do
        Templates::Destroy.call(id:)
      end
    end
  end
end
