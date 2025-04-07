module Bolt
  class ResultDescription < Base
    private

    def view_template(&)
      p class: "text-center", &
    end
  end
end
