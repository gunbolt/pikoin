require "application_system_test_case"

module Categories
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      visit_new_category_page

      assert_css "h1", text: t("views.categories.new.page_title")

      fill_in field(Category, :title), with: "My special category"
      choose("category[color]", option: "#bb3c63", allow_label_click: true)

      click_button submit_text(Category)

      assert_current_path categories_path
      assert_css ".alert-success", text: t("categories.create.success")
      assert_css "li", text: "My special category"
    end

    test "invalid form" do
      visit_new_category_page

      fill_in field(Category, :title), with: ""
      choose("category[color]", option: "#bb3c63", allow_label_click: true)

      click_button submit_text(Category)

      assert_current_path new_category_path
      assert_field field(Category, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_new_category_page
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.categories")

      click_link t("views.categories.index.new_category")
    end
  end
end
