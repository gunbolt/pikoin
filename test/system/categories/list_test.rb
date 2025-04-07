require "application_system_test_case"

module Categories
  class ListSystemTest < ApplicationSystemTestCase
    test "with categories" do
      food = create(:category, title: "Food")
      wage = create(:category, title: "Wage")

      visit_categories_page

      assert_css "h1", text: t("views.categories.index.page_title")
      assert_css "li", text: food.title
      assert_css "li", text: wage.title
      assert_link t("views.categories.index.new_category"),
        href: new_category_path
    end

    test "empty state" do
      visit_categories_page

      assert_css "h1", text: t("views.categories.index.page_title")
      assert_css "div", text: t("components.categories.empty_state.title")
      assert_css "p", text: t("components.categories.empty_state.description")
      assert_link t("components.categories.empty_state.new_category"),
        href: new_category_path
    end

    private

    def visit_categories_page
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.categories")
    end
  end
end
