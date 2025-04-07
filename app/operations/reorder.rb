class Reorder < ApplicationOperation
  Success = Data.define
  Failure = Data.define

  def initialize(model_class:, ordering:)
    @model_class = model_class
    @ordering = ordering
  end

  def call
    @model_class.transaction do
      @ordering.each do |item|
        @model_class.update!(item[:id], position: item[:position])
      end

      Success[]
    end
  rescue ActiveRecord::RecordInvalid
    Failure[]
  end
end
