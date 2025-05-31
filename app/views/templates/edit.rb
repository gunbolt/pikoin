module Views
  module Templates
    class Edit < Views::Base
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
                Bolt.PageTitle(drawer_toggle: false) do
                  t("Edit template")
                end

                Bolt.PageSubtitle do
                  t("Edit template data")
                end
              end

              Bolt.PageActions do
                Bolt.LinkButton(
                  href: template_path(@template),
                  dash: true,
                  color: :error,
                  data: {
                    turbo_method: :delete,
                    turbo_confirm: t("Are you sure you want to remove this template?")
                  }
                ) do
                  Lucide.Trash class: "size-4"
                  plain t("Remove")
                end
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
