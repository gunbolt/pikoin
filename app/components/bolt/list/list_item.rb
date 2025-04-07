module Bolt
  class ListItem < Base
    PADDING = {
      md: "p-4"
    }
    def initialize(padding: :md, **)
      @padding = padding

      super(**)
    end

    private

    def view_template(&)
      li(
        class: [
          "bg-base-100 rounded-box shadow hover:bg-base-300",
          PADDING[@padding]
        ],
        **@attributes,
        &
      )
    end
  end
end
