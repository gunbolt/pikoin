module Bolt
  class ListLegend < Base
    private

    def view_template(&)
      li class: "p-4 pb-2 text-xs opacity-60 tracking-wide", &
    end
  end
end
