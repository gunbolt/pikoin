module Insights
  class CalculateCashflow < ApplicationOperation
    prop :period, _Range?(_Union(Date, Time)), default: nil

    Result = Result.define(cashflow: Cashflow)

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
