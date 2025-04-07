require "application_system_test_case"

module Accounts
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      account = create(:account)

      visit_edit_account_page(account:)

      assert_field field(Account, :title), with: account.title

      accept_confirm t("views.accounts.edit.remove_confirm") do
        click_link I18n.t("views.accounts.edit.remove")
      end

      assert_current_path accounts_path
      assert_css ".alert-success", text: t("accounts.destroy.success")
      refute_text account.title
    end

    private

    def visit_edit_account_page(account:)
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.accounts")

      click_link account.title, href: account_records_path(account)

      click_link t("views.accounts.records.index.edit"),
        href: edit_account_path(account)
    end
  end
end
