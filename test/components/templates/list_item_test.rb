require "test_helper"

module Components::Templates
  class ListItemTest < ComponentTestCase
    test "content" do
      template = create(:template, note: "Rebound")

      render Components::Templates::ListItem.new(template:)

      assert_content template.title
      assert_content template.category.title
      assert_content template.account.title
      assert_content template.note
    end

    test "amount" do
      template = create(:template, :expense, amount_cents: 2000)
      render Components::Templates::ListItem.new(template:)

      assert_css "span.text-error", text: template.amount.format

      template = create(:template, :income, amount_cents: 40000)

      render Components::Templates::ListItem.new(template:)

      assert_css "span.text-success",
        text: template.amount.format(sign_positive: true)

      template = create(:template, :expense, amount_cents: 0)

      render Components::Templates::ListItem.new(template:)

      assert_css "span.text-current", text: template.amount.format
    end
  end
end
