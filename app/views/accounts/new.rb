module Views
  module Accounts
    class New < Views::Base
      def initialize(account:)
        @account = account
      end

      private

      def view_template
        Layouts.Zen do
          Bolt.Page do
            Bolt.PageHeader sticky: false do
              Bolt.PageHeading do
                Bolt.PageTitle(drawer_toggle: false) do
                  t("New account")
                end

                Bolt.PageSubtitle do
                  t("Set up a new account")
                end
              end
            end

            Bolt.PageBody do
              Components::Accounts.Form(account: @account)
            end
          end
        end
      end
    end
  end
end
