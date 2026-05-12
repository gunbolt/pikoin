module Components
  module ReminderOccurrences
    class Badge < Base
      def initialize(date:)
        @date = date
      end

      private

      def view_template
        if @date.past?
          Bolt.Badge(color: :error, size: :xs) do
            t("OVERDUE")
          end
        elsif @date.today?
          Bolt.Badge(color: :warning, size: :xs) do
            t("TODAY")
          end
        else
          Bolt.Badge(color: :info, size: :xs) do
            distance_of_time_in_words(Time.zone.today, @date)
          end
        end
      end
    end
  end
end
