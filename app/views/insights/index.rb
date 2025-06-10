module Views
  module Insights
    class Index < Views::Base
      def initialize(insights:)
        @insights = insights
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { t("Insights") }
                Bolt.PageSubtitle { t("Your finances overview") }
              end

              Bolt.PageActions do
                period_select
              end
            end

            Bolt.PageBody do
              div class: "flex flex-col gap-4" do
                Components::Insights.CashflowCard(cashflow: @insights.cashflow)

                div class: "grid grid-cols-1 md:grid-cols-2 gap-4" do
                  Components::Insights.SpendingBreakdownCard(
                    spending_breakdown: @insights.spending_breakdown
                  )
                end
              end
            end
          end
        end
      end

      def period_select
        form(
          action: insights_path,
          method: :get,
          class: "w-full",
          data: {controller: "auto-submit"}
        ) do
          select(
            class: "select select-primary select-sm w-full md:w-fit",
            name: "period",
            data: {action: "auto-submit#submit"}
          ) do
            Period::ALL.each_key do |period|
              option(value: period, selected: request.params[:period] == period) do
                t(period, scope: "period")
              end
            end
          end
        end
      end
    end
  end
end
