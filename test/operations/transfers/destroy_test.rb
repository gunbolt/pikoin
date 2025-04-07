require "test_helper"

module Transfers
  class DestroyTest < ActiveSupport::TestCase
    test "success" do
      id = create(:transfer).id

      result = Transfers::Destroy.call(id:)

      assert_instance_of Transfers::Destroy::Success, result
      assert result.transfer.destroyed?
    end

    test "not found" do
      id = "not-found"

      assert_raises ActiveRecord::RecordNotFound do
        Transfers::Destroy.call(id:)
      end
    end
  end
end
