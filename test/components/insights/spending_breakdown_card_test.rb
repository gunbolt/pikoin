require "test_helper"

module Components::Insights
  class SpendingBreakdownCardTest < ComponentTestCase
    test "with data" do
      spending_breakdown = SpendingBreakdown[
        items: [
          SpendingBreakdown::Item[
            label: "Food",
            color: "#ff000",
            total: Money.new(100_00)
          ]
        ]
      ]

      render Components::Insights::SpendingBreakdownCard.new(spending_breakdown:)

      assert_text t("Spending breakdown")
      refute_text t("No expenses for the chosen period")
    end

    test "without data" do
      spending_breakdown = SpendingBreakdown[items: []]

      render Components::Insights::SpendingBreakdownCard.new(spending_breakdown:)

      assert_text t("Spending breakdown")
      assert_text t("No expenses for the chosen period")
    end
  end
end
