module Views
  module Insights
    class Index < Views::Base
      def initialize(cashflow:)
        @cashflow = cashflow
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end

              Bolt.PageActions do
                period_select
              end
            end

            Bolt.PageBody do
              Components::Insights.CashflowCard(cashflow: @cashflow)
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
