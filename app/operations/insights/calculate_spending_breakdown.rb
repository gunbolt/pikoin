module Insights
  class CalculateSpendingBreakdown < ApplicationOperation
    prop :period, _Range?(_Union(Date, Time)), default: nil

    Result = Result.define(spending_breakdown: SpendingBreakdown)

    def call
      items = Category
        .joins(:records)
        .merge(Record.expense.without_transfers.on(@period))
        .select(:title, :color, "sum(records.amount_cents) AS total")
        .group(:id)
        .order("sum(amount_cents) DESC")
        .map do
          SpendingBreakdown::Item[
            label: it.title,
            color: it.color,
            total: Money.new(it.total)
          ]
        end

      Result[spending_breakdown: SpendingBreakdown[items:]]
    end
  end
end
