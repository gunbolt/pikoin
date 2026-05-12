module Components
  module Reminders
    class OccurrenceList < Base
      def initialize(occurrences:)
        @occurrences = occurrences
      end

      private

      def view_template
        Bolt.List do
          @occurrences.each do |occurrence|
            Components::Reminders::OccurrenceListItem(occurrence:)
          end
        end
      end
    end
  end
end
