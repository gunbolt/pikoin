module Components
  module Reminders
    class ListItem < Base
      def initialize(reminder:)
        @reminder = reminder
        @category = reminder.category
        @account = reminder.account
      end

      private

      def view_template
        Bolt.ListItem padding: nil do
          div class: "flex flex-row gap-2 items-center px-4" do
            a(
              href: "#",
              class: "flex flex-row gap-2 items-center justify-between w-full py-4"
            ) do
              div class: "flex flex-col gap-2" do
                span class: "font-bold" do
                  @reminder.title
                end

                div class: "flex flex-row items-center gap-2" do
                  Bolt.Dot(
                    size: "size-8",
                    color: @category.color,
                    title: @category.title
                  )

                  div class: "flex flex-col" do
                    span class: "text-lg font-semibold" do
                      @category.title
                    end
                  end
                end
              end

              div class: "flex flex-col gap-1 items-end" do
                div class: "flex flex-row items-center gap-1" do
                  Bolt.Dot(
                    size: "size-3",
                    color: @account.color,
                    title: @account.title
                  )

                  span class: "text-sm text-current/50" do
                    @account.title
                  end
                end

                Bolt.CurrencyDisplay(amount: @reminder.amount)
              end
            end
          end
        end
      end
    end
  end
end
