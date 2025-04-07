module Components
  module Layouts
    class Main < Base
      private

      def view_template(&)
        Layouts.Root do
          Bolt.Drawer do
            Bolt.DrawerContent do
              div class: "flex flex-col" do
                main_container do
                  side_menu
                  main class: "w-full mx-auto", &
                end
              end
            end

            Bolt.DrawerSide do
              Layouts.Sidenav
            end
          end
        end
      end

      def side_menu
        div class: "w-full max-w-2xs hidden lg:flex h-full sticky top-0" do
          Bolt.Stack class: "w-full" do
            a(
              href: root_path,
              class: "text-2xl font-black text-primary text-center pt-8"
            ) do
              "pikoin"
            end

            Bolt.Menu size: :lg, class: "w-full" do
              Layouts.MenuItems
            end
          end
        end
      end

      def main_container(&)
        div(
          class: "flex flex-row justify-center w-full max-w-screen-xl m-auto",
          &
        )
      end
    end
  end
end
