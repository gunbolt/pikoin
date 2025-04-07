module Views
  module Accounts
    module Records
      class Index < Views::Base
        def initialize(account:, records:, pagy:)
          @account = account
          @records = records
          @pagy = pagy
        end

        private

        def view_template
          Layouts.Main do
            Bolt.Page do
              Bolt.PageHeader do
                Bolt.PageHeading do
                  Bolt.PageTitle do
                    div class: "flex flex-row gap-2 items-center" do
                      Bolt.Dot(
                        size: "size-8",
                        color: @account.color,
                        title: @account.title
                      )

                      span class: "text-base-content" do
                        @account.title
                      end
                    end
                  end
                  Bolt.PageSubtitle do
                    Bolt.CurrencyDisplay(amount: @account.balance)
                  end
                end

                Bolt.PageActions do
                  Bolt.LinkButton(
                    href: edit_account_path(@account),
                    dash: true
                  ) do
                    Lucide.Pencil class: "size-4"
                    plain t(".edit")
                  end

                  if @records.any?
                    Bolt.LinkButton(
                      href: record_types_path(account_id: @account.id),
                      color: :primary
                    ) do
                      Lucide.Plus class: "size-4"
                      plain t(".new_record")
                    end
                  end
                end
              end

              Bolt.PageBody do
                if @records.any?
                  Components::Records.List(account: @account, records: @records, pagy: @pagy)
                else
                  Components::Records.EmptyState
                end
              end
            end
          end
        end
      end
    end
  end
end
