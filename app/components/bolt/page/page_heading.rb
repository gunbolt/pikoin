module Bolt
  class PageHeading < Base
    def view_template(&)
      div class: "grow flex flex-col gap-1", &
    end
  end
end
