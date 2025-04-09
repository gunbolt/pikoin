class InsightsController < ApplicationController
  def index
    result = Insights::CalculateCashflow.call

    render Views::Insights::Index.new(cashflow: result.cashflow)
  end
end
