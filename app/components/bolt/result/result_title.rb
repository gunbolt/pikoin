module Bolt
  class ResultTitle < Base
    private

    def view_template(&)
      div class: "text-xl font-medium text-center", &
    end
  end
end
