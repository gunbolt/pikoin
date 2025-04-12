module Insights
  class GenerateLedger < ApplicationOperation
    Result = Data.define(:ledger)

    def initialize(period:)
      @period = Period.for(period)
    end

    def call
      Result[ledger: Ledger[period: @period, entries: build_entries]]
    end

    private

    def build_entries
      running_total = Money.new(0)

      @period.steps.map do |step|
        income = Record.income.on(step).without_transfers.total
        expense = Record.expense.on(step).without_transfers.total
        running_total += income + expense

        LedgerEntry[
          label: step.to_s,
          income: income,
          expense: expense,
          running_total: running_total
        ]
      end
    end
  end
end
