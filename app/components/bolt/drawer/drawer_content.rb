module Bolt
  class DrawerContent < Base
    private

    def view_template(&)
      div class: "drawer-content bg-base-200 min-h-screen", &
    end
  end
end
