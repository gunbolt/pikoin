module Views
  module Reminders
    class Show < Views::Base
      def initialize(reminder:, occurrences:)
        @reminder = reminder
        @occurrences = occurrences
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle do
                  @reminder.title
                end
                Bolt.PageSubtitle do
                  @reminder.description
                end
              end

              Bolt.PageActions do
                Bolt.LinkButton(
                  href: "#edit-reminder",
                  dash: true
                ) do
                  Lucide.Pencil class: "size-4"
                  plain t("Edit")
                end
              end
            end

            Bolt.PageBody do
              Components::Reminders.OccurrenceList(occurrences: @occurrences)
            end
          end
        end
      end
    end
  end
end
