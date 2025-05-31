module Components
  module Categories
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("categories-empty-state.svg")

          Bolt.ResultTitle do
            t("No categories yet!")
          end

          Bolt.ResultDescription do
            t("Keep your records organized by creating custom categories that fit your needs")
          end

          Bolt.ResultActions do
            Bolt.LinkButton href: new_category_path, color: :primary do
              t("New category")
            end
          end
        end
      end
    end
  end
end
