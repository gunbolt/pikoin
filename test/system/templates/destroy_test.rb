require "application_system_test_case"

module Templates
  class DestroySystemTest < ApplicationSystemTestCase
    test "success" do
      template = create(:template)

      visit_edit_template_page(template:)

      accept_confirm t("Are you sure you want to remove this template?") do
        click_link I18n.t("Remove")
      end

      assert_current_path templates_path
      assert_css ".alert-success", text: t("Template removed")
      refute_text template.title
    end

    private

    def visit_edit_template_page(template:)
      visit root_path(as: create(:user))

      click_link t("Templates")

      click_link template.title, href: edit_template_path(template)
    end
  end
end
