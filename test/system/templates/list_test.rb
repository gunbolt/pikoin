require "application_system_test_case"

module Templates
  class ListSystemTest < ApplicationSystemTestCase
    test "with templates" do
      template_a = create(:template)
      template_b = create(:template)

      visit_templates_page

      assert_css "h1", text: t("Templates")
      assert_css "li", text: template_a.title
      assert_css "li", text: template_a.category.title
      assert_css "li", text: template_a.account.title
      assert_css "li", text: template_b.title
      assert_css "li", text: template_b.category.title
      assert_css "li", text: template_b.account.title
      assert_link t("New template"), href: new_template_path
    end

    test "empty state" do
      visit_templates_page

      assert_css "h1", text: t("Templates")
      assert_css "div", text: t("You haven’t saved any templates")
      assert_link t("New template"), href: new_template_path
    end

    private

    def visit_templates_page
      visit root_path(as: create(:user))

      click_link t("Templates")
    end
  end
end
