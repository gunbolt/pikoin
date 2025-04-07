require "test_helper"

module Records
  class DestroyTest < ActiveSupport::TestCase
    test "success" do
      id = create(:record).id

      result = Records::Destroy.call(id:)

      assert_instance_of Records::Destroy::Success, result
      assert result.record.destroyed?
    end

    test "not found" do
      id = "not-found"

      assert_raises ActiveRecord::RecordNotFound do
        Records::Destroy.call(id:)
      end
    end
  end
end
