class InsightsController < ApplicationController
  def index
    period = Period.for(params.fetch(:period, "tm"))

    result = Insights::CalculateCashflow.call(period: period.range)

    render Views::Insights::Index.new(cashflow: result.cashflow)
  end
end
