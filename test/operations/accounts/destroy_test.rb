require "test_helper"

module Accounts
  class DestroyTest < ActiveSupport::TestCase
    test "success" do
      id = create(:account).id

      result = Accounts::Destroy.call(id:)

      assert_instance_of Accounts::Destroy::Success, result
      assert result.account.destroyed?
    end

    test "failure" do
      id = "not-found"

      assert_raises ActiveRecord::RecordNotFound do
        Accounts::Destroy.call(id:)
      end
    end
  end
end
