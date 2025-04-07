module Bolt
  class LinkButton < Base
    COLORS = {
      primary: "btn-primary",
      error: "btn-error"
    }

    def initialize(color: nil, ghost: false, dash: false, **)
      @color = color
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
        ("btn-ghost" if @ghost),
        ("btn-dash" if @dash),
        @extra_classes
      ]
    end
  end
end
