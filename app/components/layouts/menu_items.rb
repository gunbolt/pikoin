module Components
  module Layouts
    class MenuItems < Base
      private

      register_value_helper :controller

      def view_template
        Bolt.MenuItem href: accounts_path, active: accounts_active? do
          Lucide.WalletMinimal(class: "size-5")

          span { t(".accounts") }
        end

        Bolt.MenuItem href: categories_path, active: categories_active? do
          Lucide.Tags(class: "size-5")
          span { t(".categories") }
        end

        Bolt.MenuItem href: templates_path, active: templates_active? do
          Lucide.BookDashed(class: "size-5")
          span { t(".templates") }
        end

        Bolt.MenuItem href: sign_out_path, data: {turbo_method: :delete} do
          Lucide.LogOut(class: "size-5")
          span { t(".sign_out") }
        end
      end

      def accounts_active? = AccountsController === controller

      def categories_active? = CategoriesController === controller

      def templates_active? = TemplatesController === controller
    end
  end
end
