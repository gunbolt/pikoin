module Components
  module Layouts
    class Sidenav < Base
      private

      def view_template
        Bolt.Menu size: :lg, class: "bg-base-200 min-h-full w-60" do
          span class: "text-2xl font-black text-primary text-center p-8" do
            "pikoin"
          end

          Layouts.MenuItems
        end
      end
    end
  end
end
