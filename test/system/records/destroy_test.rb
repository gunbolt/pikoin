require "application_system_test_case"

module Records
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      record = create(:record)

      visit_edit_record_page(record)

      accept_confirm t("Are you sure you want to remove this record?") do
        click_link t("Remove")
      end

      assert_current_path account_records_path(record.account)
      assert_css ".alert-success", text: t("Record removed")
      refute_text record.amount.format
    end

    private

    def visit_edit_record_page(record)
      account = record.account

      visit root_path(as: create(:user))

      click_link t("Accounts")

      click_link account.title, href: account_records_path(account)

      click_link record.category.title,
        href: edit_account_record_path(account, record)
    end
  end
end
