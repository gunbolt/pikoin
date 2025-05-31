module Views
  module Categories
    class Index < Views::Base
      def initialize(categories:)
        @categories = categories
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle do
                  t("Categories")
                end

                Bolt.PageSubtitle do
                  t("Keep your records organized with categories")
                end
              end

              if @categories.any?
                Bolt.PageActions do
                  Bolt.LinkButton href: new_category_path, color: :primary do
                    Lucide.Plus class: "size-4"
                    plain t("New category")
                  end
                end
              end
            end

            Bolt.PageBody do
              if @categories.any?
                Components::Categories.List(categories: @categories)
              else
                Components::Categories.EmptyState
              end
            end
          end
        end
      end
    end
  end
end
