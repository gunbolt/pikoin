module Components
  module Reminders
    class List < Base
      register_value_helper :distance_of_time_in_words

      def initialize(reminders:)
        @reminders = reminders
      end

      private

      def view_template
        div class: "flex flex-col gap-6" do
          grouped_reminders_by_date.each do |occurs_on, reminders|
            div class: "flex flex-col gap-2" do
              date_display(occurs_on)

              Bolt.List do
                reminders.each { ListItem(reminder: it) }
              end
            end
          end
        end
      end

      def grouped_reminders_by_date
        @reminders
          .sort_by { it.next_occurrence.occurs_on }
          .group_by { it.next_occurrence.occurs_on }
      end

      def date_display(date)
        div class: "flex flex-row gap-2 items-center" do
          span class: "font-bold text-sm text-current/50" do
            l(date)
          end

          if date.past?
            span class: "badge badge-xs badge-error" do
              t("OVERDUE")
            end
          elsif date.today?
            span class: "badge badge-xs badge-warning" do
              t("TODAY")
            end
          else
            span class: "badge badge-xs badge-info" do
              distance_of_time_in_words(Time.zone.today, date)
            end
          end
        end
      end
    end
  end
end
