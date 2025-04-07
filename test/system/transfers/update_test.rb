require "application_system_test_case"

module Transfers
  class UpdateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      transfer = create(:transfer)

      visit_edit_transfer_page(transfer)

      assert_css "h1", text: t("views.transfers.edit.page_title")
      assert_link t("cancel"), href: account_records_path(transfer.to_account)

      fill_in field(Transfer, :amount_cents), with: "9582"
      fill_in field(Transfer, :occurred_on), with: "2020-01-01"

      click_button submit_text(Transfer, :update)

      assert_current_path account_records_path(transfer.to_account)
      assert_css ".alert-success", text: t("transfers.update.success")
      assert_css "li", text: Money.new(9582, "BRL").format(sign_positive: true)
      assert_text I18n.l(Date.parse("2020-01-01"), format: :full_date)
    end

    test "invalid form" do
      transfer = create(:transfer)

      visit_edit_transfer_page(transfer)

      fill_in field(Transfer, :occurred_on), with: ""

      click_button submit_text(Transfer, :update)

      assert_current_path(
        edit_transfer_path(transfer, account_id: transfer.to_account.id)
      )
      assert_field field(Transfer, :occurred_on), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_edit_transfer_page(transfer)
      account = transfer.to_account
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.accounts")

      click_link account.title, href: account_records_path(account)

      click_link transfer.income_record.amount.format(sign_positive: true),
        href: edit_transfer_path(transfer, account_id: account.id)
    end
  end
end
