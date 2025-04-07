class RecordTypesController < ApplicationController
  def index
    templates = Template.order(:position)

    render Views::RecordTypes::Index.new(templates:)
  end
end
