module Insights
  class CalculateSpendingBreakdown < ApplicationOperation
    Result = Data.define(:spending_breakdown)

    def initialize(period: nil)
      @period = period
    end

    def call
      items = Category
        .joins(:records)
        .merge(Record.expense.without_transfers.on(@period))
        .select(:title, "sum(records.amount_cents) AS total")
        .group(:id)
        .order("sum(amount_cents) DESC")
        .map do
          SpendingBreakdown::Item[label: it.title, total: Money.new(it.total)]
        end

      Result[spending_breakdown: SpendingBreakdown[items:]]
    end
  end
end
