module Components
  module Insights
    class SpendingBreakdownCard < Base
      def initialize(spending_breakdown:)
        @spending_breakdown = spending_breakdown
      end

      private

      def view_template
        Bolt.Panel do
          span class: "text-lg font-bold" do
            t("Spending breakdown")
          end

          if @spending_breakdown.items.any?
            chart
          else
            empty_state
          end
        end
      end

      def chart
        canvas(
          data: {
            controller: "charts--spending-breakdown",
            charts__spending_breakdown_data_value: data.to_json
          }
        )
      end

      def empty_state
        div class: "flex items-center justify-center aspect-square w-full h-full" do
          span(class: "text-current/50") do
            t("No expenses for the chosen period")
          end
        end
      end

      def data
        @spending_breakdown.items.map do |item|
          {
            label: item.label,
            color: item.color,
            value: item.total.cents,
            formatted: item.total.format
          }
        end
      end
    end
  end
end
