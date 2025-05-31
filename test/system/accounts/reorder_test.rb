require "application_system_test_case"

module Accounts
  class ReorderSystemTest < ApplicationSystemTestCase
    test "reorder" do
      account_a = create(:account, position: 1)
      account_b = create(:account, position: 2)
      account_c = create(:account, position: 3)

      visit_accounts_page

      row_a = page.find("[data-id='#{account_a.id}']")
      row_b = page.find("[data-id='#{account_b.id}']")
      row_c = page.find("[data-id='#{account_c.id}']")

      row_c.find(".sortable-handle").drag_to(row_a.find(".sortable-handle"))
      row_a.find(".sortable-handle").drag_to(row_b.find(".sortable-handle"))

      row_1, row_2, row_3 = page.all("[data-id]")

      assert row_1.has_text?(account_c.title)
      assert row_2.has_text?(account_a.title)
      assert row_3.has_text?(account_b.title)
      assert_equal 0, account_c.reload.position
      assert_equal 1, account_a.reload.position
      assert_equal 2, account_b.reload.position
    end

    private

    def visit_accounts_page
      visit root_path(as: create(:user))

      click_link t("Accounts")
    end
  end
end
