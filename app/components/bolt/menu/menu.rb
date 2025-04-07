module Bolt
  class Menu < Base
    SIZE_CLASSES = {
      lg: "menu-lg"
    }.freeze

    def initialize(size: nil, **)
      @size = size

      super(**)
    end

    private

    def view_template(&)
      ul class: classes, &
    end

    def classes
      ["menu flex flex-col gap-1", SIZE_CLASSES[@size], @extra_classes]
    end
  end
end
