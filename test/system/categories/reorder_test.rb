require "application_system_test_case"

module Categories
  class ReorderSystemTest < ApplicationSystemTestCase
    test "reorder" do
      category_a = create(:category, position: 1)
      category_b = create(:category, position: 2)
      category_c = create(:category, position: 3)

      visit_categories_page

      row_a = page.find("[data-id='#{category_a.id}']")
      row_b = page.find("[data-id='#{category_b.id}']")
      row_c = page.find("[data-id='#{category_c.id}']")

      row_c.find(".sortable-handle").drag_to(row_a.find(".sortable-handle"))
      row_a.find(".sortable-handle").drag_to(row_b.find(".sortable-handle"))

      row_1, row_2, row_3 = page.all("[data-id]")

      assert row_1.has_text?(category_c.title)
      assert row_2.has_text?(category_a.title)
      assert row_3.has_text?(category_b.title)
      assert_equal 0, category_c.reload.position
      assert_equal 1, category_a.reload.position
      assert_equal 2, category_b.reload.position
    end

    private

    def visit_categories_page
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.categories")
    end
  end
end
