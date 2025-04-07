module Components
  module Templates
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("templates-empty-state.svg")

          Bolt.ResultTitle { t(".title") }
          Bolt.ResultDescription { t(".description") }

          Bolt.ResultActions do
            Bolt.LinkButton href: new_template_path, color: :primary do
              t(".new_template")
            end
          end
        end
      end
    end
  end
end
