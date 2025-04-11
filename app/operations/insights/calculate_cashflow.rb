module Insights
  class CalculateCashflow < ApplicationOperation
    Result = Data.define(:cashflow)

    def initialize(period: nil)
      @period = period
    end

    def call
      Result[
        cashflow: Cashflow[
          income: Record.income.on(@period).without_transfers.total,
          expense: Record.expense.on(@period).without_transfers.total
        ]
      ]
    end
  end
end
