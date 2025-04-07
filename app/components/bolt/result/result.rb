module Bolt
  class Result < Base
    private

    def view_template(&)
      div class: "flex flex-col gap-2 bg-base-100 p-8 shadow rounded-box", &
    end
  end
end
