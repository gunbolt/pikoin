require "application_system_test_case"

module Accounts
  class ListSystemTest < ApplicationSystemTestCase
    test "with accounts" do
      account_a = create(:account, initial_amount_cents: 50_00)
      account_b = create(:account, initial_amount_cents: 1_00)

      visit_accounts_page

      assert_css "h1", text: t("Accounts")
      assert_css "li", text: account_a.title
      assert_css "li", text: account_a.balance.format(sign_posistive: true)
      assert_css "li", text: account_b.title
      assert_css "li", text: account_b.balance.format(sign_posistive: true)
      assert_link t("New account"), href: new_account_path
    end

    test "empty state" do
      visit_accounts_page

      assert_css "h1", text: t("Accounts")
      assert_css "div", text: t("You don't have any accounts yet!")
      assert_link t("New account"), href: new_account_path
    end

    private

    def visit_accounts_page
      visit root_path(as: create(:user))

      click_link t("Accounts")
    end
  end
end
