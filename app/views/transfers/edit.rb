module Views
  module Transfers
    class Edit < Views::Base
      def initialize(transfer:, accounts:)
        @transfer = transfer
        @accounts = accounts
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
                  href: transfer_path(@transfer, account_id: request.params[:account_id]),
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
              Components::Transfers.Form(
                transfer: @transfer,
                accounts: @accounts,
                cancel_href: account_records_path(request.params[:account_id])
              )
            end
          end
        end
      end
    end
  end
end
