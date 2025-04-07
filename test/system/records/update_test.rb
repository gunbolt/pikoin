require "application_system_test_case"

module Records
  class UpdateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      record = create(:record)

      visit_edit_record_page(record)

      assert_css "h1", text: t("views.accounts.records.edit.page_title")
      assert_link t("cancel"), href: account_records_path(record.account)

      fill_in field(Record, :amount_cents), with: "9582"
      fill_in field(Record, :occurred_on), with: "2020-01-01"

      click_button submit_text(Record, :update)

      assert_current_path account_records_path(record.account)
      assert_css ".alert-success", text: t("accounts.records.update.success")
      assert_css "li", text: Money.new(9582, "BRL").format
      assert_text I18n.l(Date.parse("2020-01-01"), format: :full_date)
    end

    test "invalid form" do
      record = create(:record)

      visit_edit_record_page(record)

      fill_in field(Record, :occurred_on), with: ""

      click_button submit_text(Record, :update)

      assert_current_path edit_account_record_path(record.account, record)
      assert_field field(Record, :occurred_on), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
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
