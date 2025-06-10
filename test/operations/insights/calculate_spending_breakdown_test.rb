require "test_helper"

module Insights
  class CalculateSpendingBreakdownTest < ActiveSupport::TestCase
    test "total grouped by category" do
      food = create(:category, title: "Food", color: "#000000")
      car = create(:category, title: "Car", color: "#ffffff")

      create_list(:expense, 3, category: food, amount_cents: 3_00)
      create_list(:expense, 2, category: car, amount_cents: 50_00)
      create(:income)

      result = Insights::CalculateSpendingBreakdown.call
      spending_breakdown = result.spending_breakdown

      assert_equal 2, spending_breakdown.items.size

      assert_equal "Car", spending_breakdown.items.first.label
      assert_equal "#ffffff", spending_breakdown.items.first.color
      assert_equal Money.new(100_00), spending_breakdown.items.first.total

      assert_equal "Food", spending_breakdown.items.second.label
      assert_equal "#000000", spending_breakdown.items.second.color
      assert_equal Money.new(9_00), spending_breakdown.items.second.total
    end

    test "period filter" do
      expense = create(:expense, occurred_on: 1.day.ago)
      _other_expense = create(:expense, occurred_on: 1.year.ago)
      period = 7.days.ago..Time.zone.today

      result = Insights::CalculateSpendingBreakdown.call(period:)
      spending_breakdown = result.spending_breakdown

      assert_equal 1, spending_breakdown.items.size

      assert_equal expense.category.title,
        result.spending_breakdown.items.first.label

      assert_equal expense.amount.abs,
        result.spending_breakdown.items.first.total
    end
  end
end
