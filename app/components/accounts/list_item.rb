module Components
  module Accounts
    class ListItem < Base
      def initialize(account:)
        @account = account
      end

      private

      def view_template
        Bolt.ListItem padding: nil, data: {id: @account.id} do
          div class: "flex flex-row gap-2 items-center px-4" do
            div class: "cursor-move sortable-handle" do
              Lucide.GripVertical class: "size-6 stroke-base-content/60"
            end

            a(
              href: account_records_path(@account),
              class: "flex flex-row gap-2 justify-between items-center w-full py-4"
            ) do
              div class: "flex flex-row gap-2 items-center" do
                Bolt.Dot(
                  size: "size-6",
                  color: @account.color,
                  title: @account.title
                )

                span(
                  class: [
                    "text-lg font-semibold",
                    ("text-current/40" if @account.archived?)
                  ]
                ) do
                  @account.title
                end
              end

              span do
                Bolt.CurrencyDisplay(amount: @account.balance)
              end
            end
          end
        end
      end
    end
  end
end
