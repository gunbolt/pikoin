module Components
  module Layouts
    class MenuItems < Base
      private

      register_value_helper :controller

      def view_template
        Bolt.MenuItem href: insights_path, active: insights_active? do
          Lucide.Gauge(class: "size-5")

          span { t("Insights") }
        end

        Bolt.MenuItem href: accounts_path, active: accounts_active? do
          Lucide.WalletMinimal(class: "size-5")

          span { t("Accounts") }
        end

        Bolt.MenuItem href: categories_path, active: categories_active? do
          Lucide.Tags(class: "size-5")
          span { t("Categories") }
        end

        Bolt.MenuItem href: templates_path, active: templates_active? do
          Lucide.BookDashed(class: "size-5")
          span { t("Templates") }
        end

        Bolt.MenuItem href: sign_out_path, data: {turbo_method: :delete} do
          Lucide.LogOut(class: "size-5")
          span { t("Sign out") }
        end
      end

      def insights_active? = InsightsController === controller

      def accounts_active? = request.path.start_with?("/accounts")

      def categories_active? = CategoriesController === controller

      def templates_active? = TemplatesController === controller
    end
  end
end
