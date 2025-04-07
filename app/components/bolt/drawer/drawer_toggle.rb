module Bolt
  class DrawerToggle < Base
    private

    def view_template(&)
      label(
        for: "drawer-toggle",
        class: "btn btn-square btn-ghost lg:hidden",
        aria: {label: "open sidebar"}
      ) do
        Lucide.Menu class: "size-6"
      end
    end
  end
end
