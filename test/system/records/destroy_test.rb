require "application_system_test_case"

module Records
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      record = create(:record)

      visit_edit_record_page(record)

      accept_confirm t("views.accounts.records.edit.remove_confirm") do
        click_link I18n.t("views.accounts.records.edit.remove")
      end

      assert_current_path account_records_path(record.account)
      assert_css ".alert-success", text: t("accounts.records.destroy.success")
      refute_text record.amount.format
    end

    private

    def visit_edit_record_page(record)
      account = record.account

      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.accounts")

      click_link account.title, href: account_records_path(account)

      click_link record.category.title,
        href: edit_account_record_path(account, record)
    end
  end
end
