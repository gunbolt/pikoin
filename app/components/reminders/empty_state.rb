module Components
  module Reminders
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("reminders-empty-state.svg")

          Bolt.ResultTitle do
            t("Nothing to remind you of — yet")
          end

          Bolt.ResultDescription do
            t("Set up reminders for any planned expense or income")
          end

          Bolt.ResultActions do
            Bolt.LinkButton href: reminder_types_path, color: :primary do
              t("New reminder")
            end
          end
        end
      end
    end
  end
end
