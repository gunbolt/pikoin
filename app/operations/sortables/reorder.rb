module Sortables
  class Reorder < ApplicationOperation
    prop :model_class, _Descendant(Sortable)
    prop :ordering, Hash

    Success = Result.define
    Failure = Result.define

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
end
