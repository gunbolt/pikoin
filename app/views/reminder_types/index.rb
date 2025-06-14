module Views
  module ReminderTypes
    class Index < Views::Base
      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) do
                  t("Choose the reminder type")
                end

                Bolt.PageSubtitle do
                  t("Define the frequency of your reminder")
                end
              end
            end

            Bolt.PageBody do
              Bolt.Stack do
                reminder_types_grid

                Bolt.LinkButton(href: reminders_path, ghost: true) do
                  Lucide.ArrowLeft(class: "size-4")
                  plain t("Cancel")
                end
              end
            end
          end
        end
      end

      def reminder_types_grid
        div class: "grid grid-cols-3 gap-2" do
          grid_item(href: "#") do
            Lucide.Calendar1(class: "size-5")
            span { t("One time") }
          end

          grid_item(href: "#") do
            Lucide.CalendarSync(class: "size-5")
            span { t("Daily") }
          end

          grid_item(href: "#") do
            Lucide.CalendarSync(class: "size-5")
            span { t("Weekly") }
          end

          grid_item(href: "#") do
            Lucide.CalendarSync(class: "size-5")
            span { t("Monthly") }
          end

          grid_item(href: "#") do
            Lucide.CalendarSync(class: "size-5")
            span { t("Yearly") }
          end
        end
      end

      def grid_item(href:, &)
        a href: href, class: "hover:cursor-pointer hover:[&>div]:bg-base-300" do
          Bolt.Panel class: "aspect-video justify-center" do
            div class: "flex flex-col items-center gap-2 font-semibold", &
          end
        end
      end
    end
  end
end
