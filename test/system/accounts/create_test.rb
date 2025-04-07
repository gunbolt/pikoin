require "application_system_test_case"

module Accounts
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      visit_new_account_page

      assert_css "h1", text: t("views.accounts.new.page_title")
      assert_link t("cancel"), href: accounts_path

      fill_in field(Account, :title), with: "My special account"
      choose("account[color]", option: "#bb3c63", allow_label_click: true)
      fill_in field(Account, :initial_amount_cents), with: "20_00"
      click_button submit_text(Account)

      assert_current_path accounts_path
      assert_css ".alert-success", text: t("accounts.create.success")
      assert_css "li", text: "My special account"
      assert_css "li", text: Money.new(20_00).format(sign_positive: true)
    end

    test "invalid form" do
      visit_new_account_page

      fill_in field(Account, :title), with: ""
      choose("account[color]", option: "#bb3c63", allow_label_click: true)

      click_button submit_text(Account)

      assert_current_path new_account_path
      assert_field field(Account, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_new_account_page
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.accounts")

      click_link t("views.accounts.index.new_account")
    end
  end
end
