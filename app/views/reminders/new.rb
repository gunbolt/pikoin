module Views
  module Reminders
    class New < Views::Base
      def initialize(reminder:, accounts:, categories:)
        @reminder = reminder
        @accounts = accounts
        @categories = categories
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) { t("New reminder") }
                Bolt.PageSubtitle { t("Create a new reminder") }
              end
            end

            Bolt.PageBody do
              Components::Reminders.Form(
                reminder: @reminder,
                accounts: @accounts,
                categories: @categories
              )
            end
          end
        end
      end
    end
  end
end
