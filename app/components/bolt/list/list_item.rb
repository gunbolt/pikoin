module Bolt
  class ListItem < Base
    PADDING = {
      md: "p-4"
    }

    def initialize(padding: :md, hoverable: true, **)
      @padding = padding
      @hoverable = hoverable

      super(**)
    end

    private

    def view_template(&)
      li(
        class: [
          "bg-base-100 rounded-box shadow",
          ("hover:bg-base-300" if @hoverable),
          PADDING[@padding],
          @extra_classes
        ],
        **@attributes,
        &
      )
    end
  end
end
