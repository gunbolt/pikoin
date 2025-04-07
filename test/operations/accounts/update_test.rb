require "test_helper"

module Accounts
  class UpdateTest < ActiveSupport::TestCase
    test "success" do
      id = create(:account).id
      attributes = {title: "Updated title", color: "#987543"}

      result = Accounts::Update.call(id:, attributes:)

      assert_instance_of Accounts::Update::Success, result
      assert result.account.valid?
      assert_equal "Updated title", result.account.title
      assert_equal "#987543", result.account.color
    end

    test "failure" do
      id = create(:account).id
      attributes = {title: nil}

      result = Accounts::Update.call(id:, attributes:)

      assert_instance_of Accounts::Update::Failure, result
      refute result.account.valid?
      assert result.account.errors.any?
    end

    test "not found" do
      id = "not-found"
      attributes = {title: "Updated title", color: "#987543"}

      assert_raises ActiveRecord::RecordNotFound do
        Accounts::Update.call(id:, attributes:)
      end
    end
  end
end
