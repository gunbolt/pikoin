module Insights
  class CalculateCashflow < ApplicationOperation
    Success = Data.define(:cashflow)

    def initialize(period: nil)
      @period = period
    end

    def call
      Success[
        cashflow: Cashflow[
          income: total_amount(:income),
          expense: total_amount(:expense)
        ]
      ]
    end

    private

    def total_amount(group)
      records = Record.without_transfers.where(group: group)
      records = records.where(occurred_on: @period) if @period
      records.total_amount
    end
  end
end
