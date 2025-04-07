module Components
  module Categories
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("categories-empty-state.svg")

          Bolt.ResultTitle { t(".title") }
          Bolt.ResultDescription { t(".description") }

          Bolt.ResultActions do
            Bolt.LinkButton href: new_category_path, color: :primary do
              t(".new_category")
            end
          end
        end
      end
    end
  end
end
