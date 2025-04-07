module Bolt
  class Panel < Base
    private

    def view_template(&)
      div class: [
        "flex flex-col gap-2 bg-base-100 shadow rounded-box p-4",
        @extra_classes
      ], &
    end
  end
end
