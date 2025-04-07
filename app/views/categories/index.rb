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
                Bolt.PageTitle { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end

              if @categories.any?
                Bolt.PageActions do
                  Bolt.LinkButton href: new_category_path, color: :primary do
                    Lucide.Plus class: "size-4"
                    plain t(".new_category")
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
