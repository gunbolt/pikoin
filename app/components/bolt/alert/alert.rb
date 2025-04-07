module Bolt
  class Alert < Base
    COLORS = {
      success: "alert-success",
      error: "alert-error"
    }.freeze

    ICONS = {
      success: Lucide::CircleCheck,
      error: Lucide::CircleX
    }.freeze

    def initialize(color:, **)
      @color = color

      super(**)
    end

    private

    def view_template(&)
      div class: ["alert", COLORS[@color], @extra_classes], **@attributes do
        render ICONS[@color].new(class: "size-8")
        span(&)
      end
    end
  end
end
