class InsightsController < ApplicationController
  def index
    period = Period.coerce(params.fetch(:period, "tm"))
    insights = Insights::BuildData.call(period: period.range).insights

    render Views::Insights::Index.new(insights:)
  end
end
