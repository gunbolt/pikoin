module Bolt
  class PageSubtitle < Base
    def view_template(&)
      h3(&)
    end
  end
end
