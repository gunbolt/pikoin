module Views
  module Templates
    class New < Views::Base
      def initialize(template:, accounts:, categories:)
        @template = template
        @accounts = accounts
        @categories = categories
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) { t("New template") }
                Bolt.PageSubtitle { t("Create a new template") }
              end
            end

            Bolt.PageBody do
              Components::Templates.Form(
                template: @template,
                accounts: @accounts,
                categories: @categories
              )
            end
          end
        end
      end
    end
  end
end
