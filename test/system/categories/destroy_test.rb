require "application_system_test_case"

module Categories
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      category = create(:category)

      visit_edit_category_page(category:)

      assert_field field(Category, :title), with: category.title

      accept_confirm t("views.categories.edit.remove_confirm") do
        click_link I18n.t("views.categories.edit.remove")
      end

      assert_current_path categories_path
      assert_css ".alert-success", text: t("categories.destroy.success")
      refute_text category.title
    end

    private

    def visit_edit_category_page(category:)
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.categories")

      click_link category.title, href: edit_category_path(category)
    end
  end
end
