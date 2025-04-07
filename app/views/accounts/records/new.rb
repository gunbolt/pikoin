module Views
  module Accounts
    module Records
      class New < Views::Base
        def initialize(record:, accounts:, categories:)
          @record = record
          @accounts = accounts
          @categories = categories
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
              end

              Bolt.PageBody do
                Components::Records.Form(
                  record: @record,
                  accounts: @accounts,
                  categories: @categories,
                  cancel_href: record_types_path(
                    account_id: request.params[:account_id]
                  )
                )
              end
            end
          end
        end
      end
    end
  end
end
