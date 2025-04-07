module Components
  module Accounts
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("accounts-empty-state.svg")

          Bolt.ResultTitle { t(".title") }
          Bolt.ResultDescription { t(".description") }

          Bolt.ResultActions do
            Bolt.LinkButton href: new_account_path, color: :primary do
              t(".new_account")
            end
          end
        end
      end
    end
  end
end
