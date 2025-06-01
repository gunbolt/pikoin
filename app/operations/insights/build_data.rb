module Insights
  class BuildData < ApplicationOperation
    Result = Data.define(:insights)

    def initialize(period: nil)
      @period = period
    end

    def call
      Result[insights: InsightsData[cashflow:, spending_breakdown:]]
    end

    private

    def cashflow
      Insights::CalculateCashflow.call(period: @period).cashflow
    end

    def spending_breakdown
      Insights::CalculateSpendingBreakdown
        .call(period: @period)
        .spending_breakdown
    end
  end
end
