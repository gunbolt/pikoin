require "application_system_test_case"

module Records
  class ListSystemTest < ApplicationSystemTestCase
    test "with records" do
      account = create(:account)
      record_one = create(:expense, account:, amount_cents: 20_00)
      record_two = create(:income, account:, amount_cents: 12_54)

      visit_account_records_page(account)

      assert_css "h1", text: account.title
      assert_content account.balance.format(sign_positive: true)

      assert_css "li", text: record_one.category.title
      assert_css "li", text: record_one.account.title
      assert_css "li", text: record_one.amount.format(sign_positive: true)

      assert_css "li", text: record_two.category.title
      assert_css "li", text: record_two.account.title
      assert_css "li", text: record_two.amount.format(sign_positive: true)

      assert_link t("New record"),
        href: record_types_path(account_id: account.id)
    end

    test "empty state" do
      account = create(:account)

      visit_account_records_page(account)

      assert_css "h1", text: account.title
      assert_content account.balance.format(sign_positive: true)
      assert_css "div", text: t("This account doesn't have records yet")
      assert_link t("New record"),
        href: record_types_path(account_id: account.id)
    end

    test "pagination" do
      account = create(:account)
      last_week = 7.days.ago.to_date
      yesterday = 1.day.ago.to_date
      category_a = create(:category)
      category_b = create(:category)

      create_list(
        :record, 20,
        account: account,
        occurred_on: yesterday,
        category: category_a
      )
      create_list(
        :record, 16,
        account: account,
        occurred_on: last_week,
        category: category_b
      )

      visit_account_records_page(account)

      assert_text I18n.l(yesterday, format: :full_date)
      refute_text I18n.l(last_week, format: :full_date)
      assert_css "li", text: category_a.title, count: 20
      assert_button I18n.t("Previous"), disabled: true

      click_link I18n.t("Next")

      refute_text I18n.l(yesterday, format: :full_date)
      assert_text I18n.l(last_week, format: :full_date)
      assert_css "li", text: category_b.title, count: 16
      assert_button I18n.t("Next"), disabled: true

      click_link I18n.t("Previous")

      assert_css "li", text: category_a.title, count: 20
    end

    private

    def visit_account_records_page(account)
      visit root_path(as: create(:user))

      click_link t("Accounts")

      click_link account.title, href: account_records_path(account)
    end
  end
end
