module Bolt
  class ResultActions < Base
    private

    def view_template(&)
      div class: "flex pt-4 justify-center gap-4", &
    end
  end
end
