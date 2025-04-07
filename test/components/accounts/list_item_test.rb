require "test_helper"

module Components::Accounts
  class ListItemTest < ComponentTestCase
    test "title" do
      account = Account.new(id: 1, title: "My account")

      render Components::Accounts::ListItem.new(account:)

      assert_content "My account"
    end

    test "amount" do
      account = Account.new(id: 1)
      positive_balance = Money.new(10_00, "BRL")
      negative_balance = Money.new(-10_00, "BRL")
      account.stub :balance, positive_balance do
        render Components::Accounts::ListItem.new(account:)

        assert_css "span.text-success",
          text: positive_balance.format(sign_positive: true)
      end

      account.stub :balance, negative_balance do
        render Components::Accounts::ListItem.new(account:)

        assert_css "span.text-error",
          text: negative_balance.format
      end
    end
  end
end
