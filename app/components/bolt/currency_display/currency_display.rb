module Bolt
  class CurrencyDisplay < Base
    SIZES = {
      sm: "text-sm",
      lg: "text-lg"
    }.freeze

    def initialize(amount:, size: :lg, color: nil, **)
      @amount = amount
      @color = color
      @size = size

      super(**)
    end

    private

    def view_template(&)
      span(
        class: ["text-lg font-semibold", color, SIZES[@size], @extra_classes],
        **@attributes
      ) do
        @amount.format(sign_positive: true)
      end
    end

    def color
      return @color if @color.present?

      if @amount.positive?
        "text-success"
      elsif @amount.negative?
        "text-error"
      else
        "text-current"
      end
    end
  end
end
