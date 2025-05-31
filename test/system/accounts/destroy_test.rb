require "application_system_test_case"

module Accounts
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      account = create(:account)

      visit_edit_account_page(account:)

      assert_field field(Account, :title), with: account.title

      accept_confirm t("Are you sure you want to remove this account? This will also permanently remove all associated records") do
        click_link t("Remove")
      end

      assert_current_path accounts_path
      assert_css ".alert-success", text: t("Account removed")
      refute_text account.title
    end

    private

    def visit_edit_account_page(account:)
      visit root_path(as: create(:user))

      click_link t("Accounts")

      click_link account.title, href: account_records_path(account)

      click_link t("Edit"), href: edit_account_path(account)
    end
  end
end
