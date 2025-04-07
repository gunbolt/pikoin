require "application_system_test_case"

module Categories
  class UpdateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      category = create(:category)

      visit_edit_category_page(category:)

      assert_css "h1", text: t("views.categories.edit.page_title")

      assert_field field(Category, :title), with: category.title

      fill_in field(Category, :title), with: "Updated title"

      click_button submit_text(Category, :update)

      assert_current_path categories_path
      assert_css ".alert-success", text: t("categories.update.success")
      assert_css "li", text: "Updated title"
    end

    test "invalid form" do
      category = create(:category)

      visit_edit_category_page(category:)

      fill_in field(Category, :title), with: ""

      click_button submit_text(Category, :update)

      assert_current_path edit_category_path(category)
      assert_field field(Category, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_edit_category_page(category:)
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.categories")

      click_link category.title, href: edit_category_path(category)
    end
  end
end
