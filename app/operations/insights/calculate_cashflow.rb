module Insights
  class CalculateCashflow < ApplicationOperation
    Result = Data.define(:cashflow)

    def initialize(period: nil)
      @period = period
    end

    def call
      Result[
        cashflow: Cashflow[
          income: total_amount(:income),
          expense: total_amount(:expense)
        ]
      ]
    end

    private

    def total_amount(group)
      records = Record.without_transfer.where(group: group)
      records = records.where(occurred_on: @period) if @period
      records.total_amount
    end
  end
end
