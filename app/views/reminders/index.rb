module Views
  module Reminders
    class Index < Views::Base
      def initialize(reminders:)
        @reminders = reminders.load
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle do
                  t("Reminders")
                end

                Bolt.PageSubtitle do
                  t("Reminders for all your planned transactions")
                end
              end

              if @reminders.any?
                Bolt.PageActions do
                  Bolt.LinkButton href: "#new-reminder", color: :primary do
                    Lucide.Plus class: "size-4"
                    plain t("New reminder")
                  end
                end
              end
            end

            Bolt.PageBody do
              if @reminders.any?
                # Components::Reminders.List(reminders: @reminders)
              else
                Components::Reminders.EmptyState
              end
            end
          end
        end
      end
    end
  end
end
