require "application_system_test_case"

module Accounts
  class UpdateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      account = create(:account)

      visit_edit_account_page(account:)

      assert_css "h1", text: t("views.accounts.edit.page_title")
      assert_link t("cancel"), href: account_records_path(account)

      assert_field field(Account, :title), with: account.title

      fill_in field(Account, :title), with: "Updated title"

      click_button submit_text(Account, :update)

      assert_current_path account_records_path(account)
      assert_css ".alert-success", text: t("accounts.update.success")
      assert_css "h1", text: "Updated title"
    end

    test "invalid form" do
      account = create(:account)

      visit_edit_account_page(account:)

      fill_in field(Account, :title), with: ""

      click_button submit_text(Account, :update)

      assert_current_path edit_account_path(account)
      assert_field field(Account, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
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
