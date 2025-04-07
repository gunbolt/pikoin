module Views
  module Accounts
    class Edit < Views::Base
      def initialize(account:)
        @account = account
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
                  href: account_path(@account),
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
              Components::Accounts.Form(account: @account)
            end
          end
        end
      end
    end
  end
end
