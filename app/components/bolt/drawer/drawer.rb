module Bolt
  class Drawer < Base
    private

    def view_template(&)
      div class: "drawer" do
        input type: "checkbox", id: "drawer-toggle", class: "drawer-toggle"

        yield
      end
    end
  end
end
