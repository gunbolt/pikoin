module Bolt
  class Page < Base
    def view_template(&)
      div class: "flex flex-col gap-2 lg:gap-4 w-full max-w-3xl m-auto", &
    end
  end
end
