module Insights
  class BuildData < ApplicationOperation
    prop :period, _Range?(_Union(Date, Time)), default: nil

    Result = Result.define(insights: InsightsData)

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
