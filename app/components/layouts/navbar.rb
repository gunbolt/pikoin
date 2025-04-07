module Components
  module Layouts
    class Navbar < Base
      private

      def view_template
        Bolt.Navbar(
          class: [
            "flex flex-col items-center justify-center w-full fixed z-20 top-0",
            "start-0 bg-base-200 lg:hidden"
          ]
        ) do
          div class: "flex flex-row gap-2 items-center w-full max-w-screen-xl" do
            Bolt.DrawerToggle
            Bolt.NavbarTitle(href: root_path) { "pikoin" }
          end
        end
      end
    end
  end
end
