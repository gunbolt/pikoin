module Bolt
  class Stack < Base
    GAP_CLASSES = {
      xs: "gap-1",
      sm: "gap-2",
      md: "gap-4"
    }.freeze

    def initialize(gap: :md, **)
      @gap = gap

      super(**)
    end

    private

    def view_template(&)
      div(
        class: ["flex flex-col", GAP_CLASSES[@gap], @extra_classes],
        **@attributes,
        &
      )
    end
  end
end
