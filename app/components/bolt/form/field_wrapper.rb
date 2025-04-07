module Bolt
  class FieldWrapper < Base
    ORIENTATIONS = {
      vertical: "flex-col",
      horizontal: "flex-row items-center"
    }

    def initialize(orientation: :vertical, **)
      @orientation = orientation

      super(**)
    end

    private

    def view_template(&)
      div class: ["flex gap-2 w-full", ORIENTATIONS[@orientation]], &
    end
  end
end
