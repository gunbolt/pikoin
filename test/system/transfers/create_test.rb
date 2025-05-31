require "application_system_test_case"

module Transfers
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      from_account = create(:account)
      to_account = create(:account)

      visit_record_types_page(from_account)

      assert_css "h1", text: t("Choose a record type")

      click_link t("Transfer")

      assert_css "h1", text: t("New transfer")
      assert_link t("Cancel"),
        href: record_types_path(account_id: from_account.id)

      select from_account.title,
        from: field(Transfer, :from_account_id)
      select to_account.title,
        from: field(Transfer, :to_account_id)

      fill_in field(Transfer, :amount_cents), with: "8352"
      fill_in field(Transfer, :occurred_on), with: "2025-01-01"
      fill_in field(Transfer, :note), with: "Investing"

      click_button submit_text(Transfer)

      assert_current_path account_records_path(from_account)
      assert_css ".alert-success", text: t("Transfer created")
      assert_css "li", text: "Investing"
      assert_css "li", text: Money.new(-83_52).format
    end

    test "invalid form" do
      from_account = create(:account)

      visit_record_types_page(from_account)

      click_link t("Transfer")

      fill_in field(Record, :occurred_on), with: ""

      click_button submit_text(Transfer)

      assert_current_path new_transfer_path(account_id: from_account.id)
      assert_field field(Transfer, :occurred_on), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_record_types_page(account)
      visit root_path(as: create(:user))

      click_link t("Accounts")

      click_link account.title, href: account_records_path(account)

      click_link t("New record"),
        href: record_types_path(account_id: account.id)
    end
  end
end
