module Bolt
  class MenuItem < Base
    def initialize(active: false, **)
      @active = active

      super(**)
    end

    private

    def view_template(&)
      li do
        a(
          class: [
            "flex flex-row gap-2 font-semibold [&>svg]:stroke-3",
            ("bg-primary text-primary-content" if @active),
            @extra_classes
          ],
          **@attributes,
          &
        )
      end
    end
  end
end
