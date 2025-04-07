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
                Bolt.PageTitle(drawer_toggle: false) { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
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
