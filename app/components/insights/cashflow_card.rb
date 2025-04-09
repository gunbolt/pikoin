module Components
  module Insights
    class CashflowCard < Base
      PROGRESS_COLOR = {
        income: "progress-success",
        expense: "progress-error"
      }.freeze

      def initialize(cashflow:)
        @cashflow = cashflow
        @income = cashflow.income
        @expense = cashflow.expense
      end

      private

      def view_template
        Bolt.Panel do
          div class: "flex flex-col gap-4" do
            div class: "flex flex-col" do
              span class: "text-sm text-current/60" do
                t(".title")
              end

              span class: "text-lg font-bold" do
                Bolt.CurrencyDisplay(amount: @cashflow.balance)
              end
            end

            progress_bar(title: t("income"), amount: @income, group: :income)
            progress_bar(title: t("expense"), amount: @expense, group: :expense)
          end
        end
      end

      def progress_bar(title:, amount:, group:)
        div class: "flex flex-col gap-1" do
          div class: "flex flex-row justify-between" do
            span class: "text-sm" do
              title
            end

            Bolt.CurrencyDisplay(amount:, size: :sm)
          end

          progress class: ["progress h-4", PROGRESS_COLOR[group]],
            value: amount.cents.abs,
            max: [@income.cents, @expense.cents.abs].max
        end
      end
    end
  end
end
