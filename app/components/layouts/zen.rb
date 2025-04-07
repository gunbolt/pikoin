module Components
  module Layouts
    class Zen < Base
      private

      def view_template(&)
        Layouts.Root do
          div class: "flex flex-col mx-auto justify-start lg:justify-center " \
            "items-center w-full min-h-screen bg-base-200" do
            div class: "w-full max-w-prose", &
          end
        end
      end
    end
  end
end
