require "application_system_test_case"

module Categories
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      category = create(:category)

      visit_edit_category_page(category:)

      assert_field field(Category, :title), with: category.title

      accept_confirm t("Are you sure you want to remove this category? This will also permanently remove all associated records") do
        click_link t("Remove")
      end

      assert_current_path categories_path
      assert_css ".alert-success", text: t("Category removed")
      refute_text category.title
    end

    private

    def visit_edit_category_page(category:)
      visit root_path(as: create(:user))

      click_link t("Categories")

      click_link category.title, href: edit_category_path(category)
    end
  end
end
