module Bolt
  class PageBody < Base
    def view_template(&)
      div class: "flex flex-col px-4 pb-4", &
    end
  end
end
