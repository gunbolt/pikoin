module Components
  module Reminders
    class OccurrenceListItem < Base
      def initialize(occurrence:)
        @occurrence = occurrence
      end

      private

      def view_template
        if @occurrence.pending?
          pending_item
        elsif @occurrence.dismissed?
          dismissed_item
        else
          settled_item
        end
      end

      def pending_item
        Bolt.ListItem hoverable: false do
          div class: "flex flex-col gap-2" do
            div class: "flex flex-row gap-2 items-center justify-between" do
              div class: "flex flex-row gap-1 items-center" do
                Lucide.CircleDashed(class: "size-5 text-warning")

                span class: "text-lg font-semibold" do
                  l(@occurrence.occurs_on)
                end

                Components::ReminderOccurrences.Badge(date: @occurrence.occurs_on)
              end

              Bolt.CurrencyDisplay(amount: @occurrence.reminder.amount)
            end

            div class: "flex flex-row items-center justify-end gap-2" do
              Bolt.LinkButton(
                href: reminder_occurrence_path(@occurrence),
                color: :error,
                size: :sm,
                dash: true,
                data: {
                  turbo_method: :delete,
                  turbo_confirm: t("Are you sure?")
                }
              ) do
                Lucide.X(class: "size-5")
                span { t("Dismiss") }
              end

              Bolt.LinkButton(
                href: "#edit-reminder",
                color: :success,
                size: :sm,
                dash: true
              ) do
                Lucide.Check(class: "size-5")
                span { t("Settle") }
              end
            end
          end
        end
      end

      def dismissed_item
        Bolt.ListItem hoverable: false, class: "opacity-50" do
          div class: "flex flex-row gap-2 items-center justify-between" do
            div class: "flex flex-row gap-1 items-center" do
              Lucide.X(class: "size-5 text-error")

              div class: "flex flex-col" do
                span class: "text-lg font-semibold line-through" do
                  l(@occurrence.occurs_on)
                end

                span class: "text-current/50 text-xs" do
                  @occurrence.state_humanize
                end
              end
            end

            Bolt.CurrencyDisplay(amount: @occurrence.reminder.amount)
          end
        end
      end

      def settled_item
        Bolt.ListItem hoverable: false do
          div class: "flex flex-row gap-2 items-center justify-between" do
            div class: "flex flex-row gap-1 items-center" do
              Lucide.Check(class: "size-5 text-success")

              div class: "flex flex-col" do
                span class: "text-lg font-semibold" do
                  l(@occurrence.occurs_on)
                end

                span class: "text-current/50 text-xs" do
                  if @occurrence.record
                    t("Record date: %{date}") % {date: l(@occurrence.record.occurred_on)}
                  end
                end
              end
            end

            if @occurrence.record
              Bolt.CurrencyDisplay(amount: @occurrence.record.amount)
            end
          end
        end
      end
    end
  end
end
