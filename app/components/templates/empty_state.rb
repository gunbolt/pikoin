module Components
  module Templates
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("templates-empty-state.svg")

          Bolt.ResultTitle do
            t("You haven’t saved any templates")
          end

          Bolt.ResultDescription do
            t("Use templates to simplify the process of adding similar records")
          end

          Bolt.ResultActions do
            Bolt.LinkButton href: new_template_path, color: :primary do
              t("New template")
            end
          end
        end
      end
    end
  end
end
