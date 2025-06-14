class ReminderTypesController < ApplicationController
  def index
    render Views::ReminderTypes::Index.new
  end
end
