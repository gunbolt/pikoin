module Components
  module Accounts
    class EmptyState < Base
      private

      def view_template
        Bolt.Result do
          Bolt.ResultImage src: image_path("accounts-empty-state.svg")

          Bolt.ResultTitle do
            t("You don't have any accounts yet!")
          end

          Bolt.ResultDescription do
            t("After creating an account, you will be able to start recording transactions.")
          end

          Bolt.ResultActions do
            Bolt.LinkButton href: new_account_path, color: :primary do
              t("New account")
            end
          end
        end
      end
    end
  end
end
