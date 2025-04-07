require "application_system_test_case"

module Transfers
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      transfer = create(:transfer)

      visit_edit_transfer_page(transfer)

      accept_confirm t("views.transfers.edit.remove_confirm") do
        click_link I18n.t("views.transfers.edit.remove")
      end

      assert_current_path account_records_path(transfer.to_account)
      assert_css ".alert-success", text: t("transfers.destroy.success")
      refute_link t("transfer"),
        href: edit_transfer_path(transfer, account_id: transfer.to_account.id)
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
