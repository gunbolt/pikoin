module Views
  module Accounts
    module Records
      class Edit < Views::Base
        def initialize(account:, record:, accounts:, categories:)
          @account = account
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
                  Bolt.PageTitle(drawer_toggle: false) do
                    t("Edit record")
                  end

                  Bolt.PageSubtitle do
                    t("Edit record data")
                  end
                end

                Bolt.PageActions do
                  Bolt.LinkButton(
                    href: account_record_path(@account, @record),
                    dash: true,
                    color: :error,
                    data: {
                      turbo_method: :delete,
                      turbo_confirm: t("Are you sure you want to remove this record?")
                    }
                  ) do
                    Lucide.Trash class: "size-4"
                    plain t("Remove")
                  end
                end
              end

              Bolt.PageBody do
                Components::Records.Form(
                  record: @record,
                  accounts: @accounts,
                  categories: @categories,
                  cancel_href: account_records_path(@account)
                )
              end
            end
          end
        end
      end
    end
  end
end
