require "application_system_test_case"

module Transfers
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      from_account = create(:account)
      to_account = create(:account)

      visit_record_types_page(from_account)

      assert_css "h1", text: t("views.record_types.index.page_title")

      click_link t("transfer")

      assert_css "h1", text: t("views.transfers.new.page_title")
      assert_link t("cancel"),
        href: record_types_path(account_id: from_account.id)

      select from_account.title,
        from: field(Record, :from_account_id)
      select to_account.title,
        from: field(Record, :to_account_id)

      fill_in field(Record, :amount_cents), with: "8352"
      fill_in field(Record, :occurred_on), with: "2025-01-01"
      fill_in field(Record, :note), with: "Investing"

      click_button submit_text(Transfer)

      assert_current_path account_records_path(from_account)
      assert_css ".alert-success", text: t("transfers.create.success")
      assert_css "li", text: "Investing"
      assert_css "li", text: Money.new(-83_52).format
    end

    test "invalid form" do
      from_account = create(:account)

      visit_record_types_page(from_account)

      click_link t("transfer")

      fill_in field(Record, :occurred_on), with: ""

      click_button submit_text(Transfer)

      assert_current_path new_transfer_path(account_id: from_account.id)
      assert_field field(Transfer, :occurred_on), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_record_types_page(account)
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.accounts")

      click_link account.title, href: account_records_path(account)

      click_link t("components.records.empty_state.new_record"),
        href: record_types_path(account_id: account.id)
    end
  end
end
