require "test_helper"

module Components::Records
  class ListItemTest < ComponentTestCase
    test "content" do
      record = create(:record)

      render Components::Records::ListItem.new(record:)

      assert_content record.note
      assert_content record.account.title
    end

    test "main text" do
      record = create(:record)

      render Components::Records::ListItem.new(record:)

      assert_content record.category.title
      refute_content t("transfer")

      record = create(:transfer).expense_record

      render Components::Records::ListItem.new(record:)

      assert_content t("transfer")
    end

    test "amount" do
      record = create(:expense)
      render Components::Records::ListItem.new(record:)

      assert_css "span.text-error", text: record.amount.format

      record = create(:income)

      render Components::Records::ListItem.new(record:)

      assert_css "span.text-success",
        text: record.amount.format(sign_positive: true)

      record = create(:transfer).income_record

      render Components::Records::ListItem.new(record:)

      assert_css "span.text-current",
        text: record.amount.format(sign_positive: true)
    end
  end
end
