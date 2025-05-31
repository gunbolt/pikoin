require "application_system_test_case"

module Templates
  class UpdateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      template = create(:template)

      visit_edit_template_page(template:)

      assert_css "h1", text: t("Edit template")

      fill_in field(Template, :title), with: "New template title"

      click_button submit_text(Template, :update)

      assert_current_path templates_path
      assert_css ".alert-success", text: t("Template updated")
      assert_css "li", text: "New template title"
    end

    test "invalid form" do
      template = create(:template)

      visit_edit_template_page(template:)

      fill_in field(Template, :title), with: ""

      click_button submit_text(Template, :update)

      assert_current_path edit_template_path(template)
      assert_field field(Template, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_edit_template_page(template:)
      visit root_path(as: create(:user))

      click_link t("Templates")

      click_link template.title, href: edit_template_path(template)
    end
  end
end
