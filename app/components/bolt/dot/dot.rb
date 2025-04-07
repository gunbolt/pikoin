module Bolt
  class Dot < Base
    def initialize(color:, size:, **)
      @color = color
      @size = size

      super(**)
    end

    private

    def view_template(&)
      span(
        class: [
          "flex items-center justify-center rounded-full aspect-square",
          @size,
          @extra_classes
        ],
        style: {background_color: @color},
        **@attributes,
        &
      )
    end
  end
end
