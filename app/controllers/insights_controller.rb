class InsightsController < ApplicationController
  def index
    render Views::Insights::Index.new
  end
end
