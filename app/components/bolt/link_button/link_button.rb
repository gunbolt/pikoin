module Bolt
  class LinkButton < Base
    COLORS = {
      primary: "btn-primary",
      success: "btn-success",
      error: "btn-error"
    }.freeze

    SIZES = {
      sm: "btn-sm"
    }.freeze

    def initialize(color: nil, size: nil, ghost: false, dash: false, **)
      @color = color
      @size = size
      @ghost = ghost
      @dash = dash

      super(**)
    end

    private

    def view_template(&)
      a class: classes, **@attributes, &
    end

    def classes
      [
        "btn",
        COLORS[@color],
        SIZES[@size],
        ("btn-ghost" if @ghost),
        ("btn-dash" if @dash),
        @extra_classes
      ]
    end
  end
end
