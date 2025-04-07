module Views
  module Categories
    class Edit < Views::Base
      def initialize(category:)
        @category = category
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end

              Bolt.PageActions do
                Bolt.LinkButton(
                  href: category_path(@category),
                  dash: true,
                  color: :error,
                  data: {
                    turbo_method: :delete,
                    turbo_confirm: t(".remove_confirm")
                  }
                ) do
                  Lucide.Trash class: "size-4"
                  plain t(".remove")
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
