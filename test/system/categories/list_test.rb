require "application_system_test_case"

module Categories
  class ListSystemTest < ApplicationSystemTestCase
    test "with categories" do
      food = create(:category, title: "Food")
      wage = create(:category, title: "Wage")

      visit_categories_page

      assert_css "h1", text: t("Categories")
      assert_css "li", text: food.title
      assert_css "li", text: wage.title
      assert_link t("New category"), href: new_category_path
    end

    test "empty state" do
      visit_categories_page

      assert_css "h1", text: t("Categories")
      assert_css "div", text: t("No categories yet!")
      assert_link t("New category"), href: new_category_path
    end

    private

    def visit_categories_page
      visit root_path(as: create(:user))

      click_link t("Categories")
    end
  end
end
