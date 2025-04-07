module Bolt
  class PageActions < Base
    def view_template(&)
      div class: "w-full lg:w-fit flex flex-row justify-end gap-1", &
    end
  end
end
