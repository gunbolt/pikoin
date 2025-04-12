module Bolt
  class PageHeader < Base
    def initialize(sticky: true)
      @sticky = sticky
    end

    private

    def view_template(&)
      div class: [
        "flex flex-col justify-between gap-4 w-full px-4 bg-base-200 " \
        "lg:flex-row lg:items-center lg:gap-1 py-4",
        ("top-0 sticky z-50" if @sticky)
      ], &
    end
  end
end
