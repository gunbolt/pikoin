require "test_helper"

module Insights
  class CalculateClashflowTest < ActiveSupport::TestCase
    test "income calc" do
      create(:record, :income, amount_cents: 12_00)
      create(:record, :income, amount_cents: 4_00)
      create(:record, :expense, amount_cents: 10_00)
      create(:transfer, amount_cents: 84_00)

      cashflow = Insights::CalculateCashflow.call.cashflow

      assert_equal Money.new(16_00), cashflow.income
    end

    test "expense calc" do
      create(:record, :expense, amount_cents: 23_00)
      create(:record, :expense, amount_cents: 5_00)
      create(:record, :income, amount_cents: 3_00)
      create(:transfer, amount_cents: 120_00)

      cashflow = Insights::CalculateCashflow.call.cashflow

      assert_equal Money.new(-28_00), cashflow.expense
    end

    test "period filter" do
      create(:record, :income, amount_cents: 12_00, occurred_on: 1.day.ago)
      create(:record, :income, amount_cents: 4_00, occurred_on: 1.year.ago)
      create(:record, :expense, amount_cents: 10_00, occurred_on: 2.days.ago)
      create(:record, :expense, amount_cents: 3_00, occurred_on: 6.months.ago)
      create(:transfer, amount_cents: 84_00, occurred_on: 1.day.ago)

      period = 3.days.ago..Time.zone.today
      cashflow = Insights::CalculateCashflow.call(period:).cashflow

      assert_equal Money.new(12_00), cashflow.income
      assert_equal Money.new(-10_00), cashflow.expense

      period = 2.years.ago..3.months.ago
      cashflow = Insights::CalculateCashflow.call(period:).cashflow

      assert_equal Money.new(4_00), cashflow.income
      assert_equal Money.new(-3_00), cashflow.expense
    end
  end
end
