class OrderingController < ApplicationController
  ALLOWED_RESOURCES = %w[account category template]

  def update
    ordering = ordering_params

    case Reorder.call(model_class:, ordering:)
    in Reorder::Success
      head :ok
    in Reorder::Failure
      head :unprocessable_entity
    end
  end

  private

  def ordering_params
    params.expect(items: [%i[id position]])
  end

  def model_class
    return unless ALLOWED_RESOURCES.include?(params[:resource])

    params[:resource].camelcase.constantize
  end
end
