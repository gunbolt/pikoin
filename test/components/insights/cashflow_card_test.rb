require "test_helper"

module Components::Insights
  class CashflowCardTest < ComponentTestCase
    test "balance" do
      cashflow = Cashflow[
        income: Money.new(10_00),
        expense: Money.new(-15_00)
      ]

      render Components::Insights::CashflowCard.new(cashflow:)

      assert_text t("Cashflow")
      assert_css ".text-error", text: Money.new(-5_00).format
    end

    test "income" do
      cashflow = Cashflow[
        income: Money.new(10_00),
        expense: Money.new(-15_00)
      ]

      render Components::Insights::CashflowCard.new(cashflow:)

      assert_text t("Income")
      assert_css ".text-success",
        text: Money.new(10_00).format(sign_positive: true)
      assert_css ".progress-success[max='1500'][value='1000']"
    end

    test "expense" do
      cashflow = Cashflow[
        income: Money.new(19_00),
        expense: Money.new(-15_00)
      ]

      render Components::Insights::CashflowCard.new(cashflow:)

      assert_text t("Expense")
      assert_css ".text-error",
        text: Money.new(-15_00).format
      assert_css ".progress-error[max='1900'][value='1500']"
    end
  end
end
