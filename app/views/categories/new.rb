module Views
  module Categories
    class New < Views::Base
      def initialize(category:)
        @category = category
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) do
                  t("New category")
                end

                Bolt.PageSubtitle do
                  t("Set up a new category")
                end
              end
            end

            Bolt.PageBody do
              Components::Categories.Form(category: @category)
            end
          end
        end
      end
    end
  end
end
