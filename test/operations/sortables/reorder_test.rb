require "test_helper"

module Sortables
  class ReorderTest < ActiveSupport::TestCase
    test "success" do
      account_a = create(:account, position: 2)
      account_b = create(:account, position: 5)

      result = Reorder.call(model_class: Account, ordering: [
        {id: account_a.id, position: 90},
        {id: account_b.id, position: 2953}
      ])

      assert_kind_of Reorder::Success, result
      assert_equal 90, account_a.reload.position
      assert_equal 2953, account_b.reload.position
    end

    test "failure" do
      account_a = create(:account, position: 2)
      account_b = create(:account, position: 5)

      result = Reorder.call(model_class: Account, ordering: [
        {id: account_a.id, position: 90},
        {id: account_b.id, position: nil}
      ])

      assert_kind_of Reorder::Failure, result
      assert_equal 2, account_a.reload.position
      assert_equal 5, account_b.reload.position
    end
  end
end
