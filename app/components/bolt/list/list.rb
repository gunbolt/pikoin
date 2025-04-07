module Bolt
  class List < Base
    private

    def view_template(&)
      ul class: "flex flex-col gap-2", **@attributes, &
    end
  end
end
