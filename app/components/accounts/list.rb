module Components
  module Accounts
    class List < Base
      def initialize(accounts:)
        @accounts = accounts
      end

      private

      def view_template
        Bolt.List(
          data: {
            controller: "sortable",
            sortable_endpoint_value: ordering_path(Account.name.parameterize)
          }
        ) do
          @accounts.each { ListItem(account: it) }
        end
      end
    end
  end
end
