module Bolt
  class Badge < Base
    COLORS = {
      info: "badge-info",
      warning: "badge-warning",
      error: "badge-error"
    }.freeze

    SIZES = {
      xs: "badge-xs"
    }.freeze

    def initialize(color:, size:, **)
      @color = color
      @size = size

      super(**)
    end

    private

    def view_template(&)
      div class: ["badge", COLORS[@color], SIZES[@size]], &
    end
  end
end
