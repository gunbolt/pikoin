module Bolt
  class DrawerSide < Base
    private

    def view_template(&)
      div class: "drawer-side z-100", data: {turbo_temporary: true} do
        label(
          for: "drawer-toggle",
          class: "drawer-overlay",
          aria_label: "close sidebar"
        )

        yield
      end
    end
  end
end
