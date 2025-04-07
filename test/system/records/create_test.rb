require "application_system_test_case"

module Records
  class CreateSystemTest < ApplicationSystemTestCase
    test "expense valid form" do
      account = create(:account, position: 2)
      category = create(:category, position: 3)
      other_account = create(:account, position: 1)
      other_category = create(:category, position: 1)

      visit_record_types_page(account)

      assert_css "h1", text: t("views.record_types.index.page_title")
      assert_link t("cancel"), href: account_records_path(account)

      click_link t("expense")

      assert_css "h1", text: t("views.accounts.records.new.page_title")
      assert_link t("cancel"), href: record_types_path(account_id: account.id)

      assert_checked_field t("expense")
      refute_checked_field t("income")

      assert_select field(Record, :account_id),
        selected: account.title,
        options: [account.title, other_account.title]
      assert_select field(Record, :category_id),
        selected: other_category.title,
        options: [other_category.title, category.title]
      fill_in field(Record, :amount_cents), with: "1000"
      fill_in field(Record, :occurred_on), with: "2025-01-01"
      fill_in field(Record, :note), with: "Gunbolt - Rebound"

      click_button submit_text(Record)

      assert_current_path account_records_path(account)
      assert_css ".alert-success", text: t("accounts.records.create.success")
      assert_css "li", text: "Gunbolt - Rebound"
      assert_css "li", text: Money.new(-10_00).format
    end

    test "income valid form" do
      account = create(:account)
      category = create(:category)

      visit_record_types_page(account)

      assert_css "h1", text: t("views.record_types.index.page_title")
      assert_link t("cancel"), href: account_records_path(account)

      click_link t("income")

      assert_css "h1", text: t("views.accounts.records.new.page_title")
      assert_link t("cancel"), href: record_types_path(account_id: account.id)

      assert_checked_field t("income")
      refute_checked_field t("expense")

      select account.title, from: field(Record, :account_id)
      select category.title, from: field(Record, :category_id)
      fill_in field(Record, :amount_cents), with: "1452"
      fill_in field(Record, :occurred_on), with: "2025-01-01"
      fill_in field(Record, :note), with: "Gunbolt - Rebound"

      click_button submit_text(Record)

      assert_current_path account_records_path(account)
      assert_css ".alert-success", text: t("accounts.records.create.success")
      assert_css "li", text: "Gunbolt - Rebound"
      assert_css "li", text: Money.new(14_52).format(sign_positive: true)
    end

    test "using template" do
      account = create(:account)
      template = create(
        :template, :income, amount_cents: 8532, note: "Gunbolt - Rebound"
      )

      visit_record_types_page(account)

      assert_css "h1", text: t("views.record_types.index.page_title")
      assert_link t("cancel"), href: account_records_path(account)

      click_link template.title

      assert_css "h1", text: t("views.accounts.records.new.page_title")
      assert_link t("cancel"), href: record_types_path(account_id: account.id)

      assert_checked_field t("income")
      assert_select field(Record, :account_id),
        selected: template.account.title
      assert_select field(Record, :category_id),
        selected: template.category.title
      assert_field field(Record, :amount_cents), with: "85,32"
      assert_field field(Record, :note), with: template.note
      assert_field field(Record, :occurred_on), with: Time.zone.today

      select account.title, from: field(Record, :account_id)
      fill_in field(Record, :occurred_on), with: "2025-01-01"

      click_button submit_text(Record)

      assert_current_path account_records_path(account)
      assert_css ".alert-success", text: t("accounts.records.create.success")
      assert_css "li", text: template.note
      assert_css "li", text: template.amount.format(sign_positive: true)
    end

    test "invalid form" do
      account = create(:account)
      visit_record_types_page(account)

      click_link t("expense")

      fill_in field(Record, :occurred_on), with: ""

      click_button submit_text(Record)

      assert_current_path new_account_record_path(account, group: :expense)
      assert_field field(Record, :occurred_on), with: ""
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
