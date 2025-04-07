module Components
  module Records
    class List < Base
      def initialize(account:, records:, pagy:)
        @account = account
        @records = records
        @pagy = pagy
      end

      private

      def view_template
        div class: "flex flex-col gap-6" do
          grouped_records_by_date.each do |occurred_on, records|
            div class: "flex flex-col gap-2" do
              div class: "flex flex-row justify-between" do
                span class: "font-bold text-sm text-current/50" do
                  l(occurred_on, format: :full_date)
                end

                span do
                  Bolt.CurrencyDisplay(
                    amount: @account.balance(on: occurred_on),
                    size: :sm,
                    class: "opacity-80"
                  )
                end
              end

              Bolt.List do
                records.each { ListItem(record: it) }
              end
            end
          end

          Bolt.Pagination(pagy: @pagy)
        end
      end

      def grouped_records_by_date
        @records.group_by(&:occurred_on)
      end
    end
  end
end
